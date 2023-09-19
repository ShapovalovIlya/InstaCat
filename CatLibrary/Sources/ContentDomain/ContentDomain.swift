//
//  ContentDomain.swift
//
//
//  Created by Илья Шаповалов on 18.09.2023.
//

import Foundation
import Combine
import SwiftUDF
import Models
import Dependencies

public struct ContentDomain: ReducerDomain {
    public typealias ImageRequest = (Endpoint) -> AnyPublisher<BreedImage, Error>
    
    //MARK: - State
    public struct State: Equatable {
        public var breedImage: BreedImage?
        public var breed: Breed?
        public var breedDetail: BreedDetail?
        public var dataLoadingStatus: DataLoadingStatus
        
        public init(
            breedImage: BreedImage? = nil,
            breed: Breed? = nil,
            breedDetail: BreedDetail? = nil,
            dataLoadingStatus: DataLoadingStatus = .none
        ) {
            self.breedImage = breedImage
            self.breed = breed
            self.breedDetail = breedDetail
            self.dataLoadingStatus = dataLoadingStatus
        }
    }
    
    //MARK: - Action
    public enum Action: Equatable {
        case setBreed(Breed)
        case _fetchImageRequest(String)
        case _fetchImageResponse(Result<BreedImage, Error>)
        
        public static func == (lhs: ContentDomain.Action, rhs: ContentDomain.Action) -> Bool {
            String(describing: lhs) == String(describing: rhs)
        }
    }
    
    //MARK: - Dependencies
    private let getImageRequest: ImageRequest
    
    //MARK: - init(_:)
    public init(
        getImageRequest: @escaping ImageRequest
    ) {
        self.getImageRequest = getImageRequest
    }
    
    //MARK: - Reducer
    public func reduce(_ state: inout State, action: Action) -> AnyPublisher<Action, Never> {
        switch action {
        case let .setBreed(breed):
            state.breed = breed
            guard 
                state.dataLoadingStatus != .loading,
                let id = state.breed?.id
            else {
                break
            }
            return run(._fetchImageRequest(id))
            
        case let ._fetchImageRequest(breedId):
            state.dataLoadingStatus = .loading
            return getImageRequest(.photos(breedIDs: breedId, limit: 1))
                .map(toSuccessAction(_:))
                .catch(toFailureAction(_:))
                .eraseToAnyPublisher()
            
        case let ._fetchImageResponse(.success(breedImage)):
            state.dataLoadingStatus = .none
            state.breedImage = breedImage
            
        case let ._fetchImageResponse(.failure(error)):
            state.dataLoadingStatus = .error(error)
            print(error)
        }
        return empty()
    }
    
    //MARK: - Preview store
    static let previewStore = Store(
        state: Self.State(),
        reducer: Self(getImageRequest: { _ in
            Just<BreedImage>(.sample)
                .setFailureType(to: Error.self)
                .delay(for: 3, scheduler: DispatchQueue.main)
                .eraseToAnyPublisher()
        })
    )
}

private extension ContentDomain {
    //MARK: - Private methods
    func toSuccessAction(_ imageModel: BreedImage) -> Action {
        ._fetchImageResponse(.success(imageModel))
    }
    
    func toFailureAction(_ error: Error) -> Just<Action> {
        .init(._fetchImageResponse(.failure(error)))
    }
}
