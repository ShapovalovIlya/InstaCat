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

public struct ContentDomain: ReducerDomain {
    //MARK: - State
    public struct State: Equatable {
        public var breed: Breed?
        
        public init(
            breed: Breed? = nil
        ) {
            self.breed = breed
        }
    }
    
    //MARK: - Action
    public enum Action: Equatable {
        case setBreed(Breed)
    }
    
    //MARK: - init(_:)
    public init() {}
    
    //MARK: - Reducer
    public func reduce(_ state: inout State, action: Action) -> AnyPublisher<Action, Never> {
        switch action {
        case let .setBreed(breed):
            state.breed = breed
        }
        return empty()
    }
    
    //MARK: - Preview store
    static let previewStore = Store(
        state: Self.State(),
        reducer: Self()
    )
}
