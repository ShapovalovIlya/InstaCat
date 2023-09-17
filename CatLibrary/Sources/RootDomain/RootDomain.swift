//
//  RootDomain.swift
//  
//
//  Created by Илья Шаповалов on 11.09.2023.
//

import Foundation
import Combine
import SwiftUDF
import OSLog
import Models
import Dependencies

public struct RootDomain: ReducerDomain {
    public typealias BreedRequest = (Endpoint) -> AnyPublisher<[Breed], Error>
    
    //MARK: - State
    public struct State: Equatable {
        public var breeds: [Breed]
        public var selectedBreed: Breed?
        
        public init(
            breeds: [Breed] = .init(),
            selectedBreed: Breed? = nil
        ) {
            self.breeds = breeds
            self.selectedBreed = selectedBreed
        }
    }
    
    //MARK: - Action
    public enum Action: Equatable {
        case windowDidLoad
        case setSelectedBreed(Breed)
        case _fetchBreedsRequest
        case _fetchBreedsResponse(Result<[Breed], Error>)
        
        public static func == (lhs: RootDomain.Action, rhs: RootDomain.Action) -> Bool {
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
        case .windowDidLoad:
            return run(._fetchBreedsRequest)
            
        case ._fetchBreedsRequest:
            return getRequest(.breeds)
                .map(toSuccessAction)
                .catch(toFailureAction)
                .eraseToAnyPublisher()
            
        case let ._fetchBreedsResponse(.success(breeds)):
            state.breeds = breeds
            
        case let ._fetchBreedsResponse(.failure(error)):
            print(error)
            
        case let .setSelectedBreed(breed):
            state.selectedBreed = breed
        }
        
        return empty()
    }
}

private extension RootDomain {
    func toSuccessAction(_ breeds: [Breed]) -> Action {
        ._fetchBreedsResponse(.success(breeds))
    }
    
    func toFailureAction(_ error: Error) -> Just<Action> {
        Just(._fetchBreedsResponse(.failure(error)))
    }
}
