//
//  GalleriaDomain.swift
//
//
//  Created by Илья Шаповалов on 20.09.2023.
//

import Foundation
import SwiftUDF
import Combine
import Models
import Dependencies

public struct GalleriaDomain: ReducerDomain {
    public typealias ImageRequest = (Endpoint) -> AnyPublisher<[BreedImage], Error>
    
    //MARK: - State
    public struct State: Equatable {
        public var breedId: String
        public var images: [BreedImage]
        public var limit: Int
        public var dataLoadingStatus: DataLoadingStatus
        
        public init(
            breedId: String,
            images: [BreedImage] = .init(),
            limit: Int = 10,
            dataLoadingStatus: DataLoadingStatus = .none
        ) {
            self.breedId = breedId
            self.images = images
            self.limit = limit
            self.dataLoadingStatus = dataLoadingStatus
        }
    }
    
    //MARK: - Action
    public enum Action: Equatable {
        case viewWillAppear
        case willDisplayImageAt(Int)
        case _fetchImageRequest
        case _fetchImageResponse(Result<[BreedImage], Error>)
        
        public static func == (lhs: GalleriaDomain.Action, rhs: GalleriaDomain.Action) -> Bool {
            String(describing: lhs) == String(describing: rhs)
        }
    }
    
    //MARK: - Dependencies
    private let getImageRequest: ImageRequest
    
    //MARK: - init(_:)
    public init(getImageRequest: @escaping ImageRequest) {
        self.getImageRequest = getImageRequest
    }
    
    //MARK: - Reducer
    public func reduce(_ state: inout State, action: Action) -> AnyPublisher<Action, Never> {
        switch action {
        case .viewWillAppear:
            return run(._fetchImageRequest)
            
        case let .willDisplayImageAt(index):
            guard index > state.images.count - 5 else {
                break
            }
   //         return run(._fetchImageRequest)
            
        case ._fetchImageRequest:
            state.dataLoadingStatus = .loading
            
            return getImageRequest(state.toEndpointSceme)
                .map(toSuccessAction(_:))
                .catch(toFailAction(_:))
                .eraseToAnyPublisher()
            
        case let ._fetchImageResponse(.success(images)):
            state.images.append(contentsOf: images)
            
        case let ._fetchImageResponse(.failure(error)):
            state.dataLoadingStatus = .error(error)
        }
        return empty()
    }
}

private extension GalleriaDomain {
    //MARK: - Private methods
    func toSuccessAction(_ images: [BreedImage]) -> Action {
        ._fetchImageResponse(.success(images))
    }
    
    func toFailAction(_ error: Error) -> Just<Action> {
        .init(._fetchImageResponse(.failure(error)))
    }
}


private extension GalleriaDomain.State {
    //MARK: - Private properties
    var toEndpointSceme: Endpoint {
        .photos(
            breedIDs: breedId,
            limit: limit,
            page: images.count
        )
    }
}
