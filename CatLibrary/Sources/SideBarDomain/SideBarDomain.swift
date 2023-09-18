//
//  SideBarDomain.swift
//
//
//  Created by Илья Шаповалов on 14.09.2023.
//

import Foundation
import SwiftUDF
import Combine
import Models
import Dependencies

public struct SideBarDomain: ReducerDomain {
    public typealias BreedRequest = (Endpoint) -> AnyPublisher<[Breed], Error>
    
    //MARK: - State
    public struct State {
        public var breeds: [Breed]
        public var selectedBreed: Breed?
        public var dataLoadingStatus: DataLoadingStatus
        
        //MARK: - init(_:)
        public init(
            breeds: [Breed] = .init(),
            selectedBreed: Breed? = nil,
            dataLoadingStatus: DataLoadingStatus = .none
        ) {
            self.breeds = breeds
            self.selectedBreed = selectedBreed
            self.dataLoadingStatus = dataLoadingStatus
        }
    }
    
    //MARK: - Action
    public enum Action: Equatable {
        case viewWillAppear
        case didSelectBreedAt(Int)
        case _fetchBreedsRequest
        case _fetchBreedsResponse(Result<[Breed], Error>)
        
        public static func == (lhs: SideBarDomain.Action, rhs: SideBarDomain.Action) -> Bool {
            String(describing: lhs) == String(describing: rhs)
        }
    }
    
    //MARK: - Dependencies
    private let getRequest: BreedRequest
    
    //MARK: - init(_:)
    public init(getRequest: @escaping BreedRequest) {
        self.getRequest = getRequest
    }
    
    //MARK: - Reducer
    public func reduce(_ state: inout State, action: Action) -> AnyPublisher<Action, Never> {
        switch action {
        case .viewWillAppear:
            guard state.dataLoadingStatus != .loading else {
                break
            }
            return run(._fetchBreedsRequest)
            
        case let .didSelectBreedAt(index):
            if index < state.breeds.count {
                state.selectedBreed = state.breeds[index]
            }
            
        case ._fetchBreedsRequest:
            state.dataLoadingStatus = .loading
            return getRequest(.breeds)
                .map(toSuccessAction)
                .catch(toFailureAction)
                .eraseToAnyPublisher()
            
        case let ._fetchBreedsResponse(.success(breeds)):
            state.dataLoadingStatus = .none
            state.breeds = breeds
            
        case let ._fetchBreedsResponse(.failure(error)):
            state.dataLoadingStatus = .error(error)
            
        }
        return empty()
    }
    
    //MARK: - Preview store
    static let previewStore = Store(
        state: Self.State(),
        reducer: Self(getRequest: { _ in
            Just([Breed.sample])
                .setFailureType(to: Error.self)
                .delay(for: 3, scheduler: DispatchQueue.main)
                .eraseToAnyPublisher()
        })
    )
}

private extension SideBarDomain {
    func toSuccessAction(_ breeds: [Breed]) -> Action {
        ._fetchBreedsResponse(.success(breeds))
    }
    
    func toFailureAction(_ error: Error) -> Just<Action> {
        Just(._fetchBreedsResponse(.failure(error)))
    }
}
