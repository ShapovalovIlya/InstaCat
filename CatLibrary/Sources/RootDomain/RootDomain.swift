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
    public struct State {
        
        public init() {}
    }
    
    //MARK: - Action
    public enum Action: Equatable {
        case windowDidLoad
        case _fetchBreedsRequest
        case _fetchBreedsResponse(Result<[Breed], Error>)
        
        public static func == (lhs: RootDomain.Action, rhs: RootDomain.Action) -> Bool {
            String(describing: lhs) == String(describing: rhs)
        }
    }
    
    //MARK: - Dependencies
    private let breedsPublisher: BreedRequest
    
    //MARK: - init(_:)
    public init(breedsPublisher: @escaping BreedRequest) {
        self.breedsPublisher = breedsPublisher
    }
    
    //MARK: - Reducer
    public func reduce(_ state: inout State, action: Action) -> AnyPublisher<Action, Never> {
        switch action {
        case .windowDidLoad:
            return run(._fetchBreedsRequest)
            
        case ._fetchBreedsRequest:
            return breedsPublisher(.breeds)
                .map(toSuccessAction)
                .catch(toFailureAction)
                .eraseToAnyPublisher()
            
        case let ._fetchBreedsResponse(.success(breeds)):
            break
            
        case let ._fetchBreedsResponse(.failure(error)):
            break
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
