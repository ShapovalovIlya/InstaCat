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

public struct SideBarDomain: ReducerDomain {
    public struct State {
        public var breeds: [Breed]
        
        public init(breeds: [Breed] = .init()) {
            self.breeds = breeds
        }
    }
    
    public enum Action {
        case loadBreeds([Breed])
    }
    
    public func reduce(_ state: inout State, action: Action) -> AnyPublisher<Action, Never> {
        switch action {
        case let .loadBreeds(breeds):
            state.breeds = breeds
        }
        return empty()
    }
    
    static let previewStore = Store(
        state: Self.State(),
        reducer: Self()
    )
}
