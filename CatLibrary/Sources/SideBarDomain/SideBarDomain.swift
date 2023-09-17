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
    //MARK: - State
    public struct State {
        public var breeds: [Breed]
        public var selectedBreed: Breed?
        
        //MARK: - init(_:)
        public init(
            breeds: [Breed] = .init(),
            selectedBreed: Breed? = nil
        ) {
            self.breeds = breeds
            self.selectedBreed = selectedBreed
        }
    }
    
    //MARK: - Action
    public enum Action {
        case setBreeds([Breed])
        case didSelectBreedAt(Int)
    }
    
    //MARK: - init(_:)
    public init() {}
    
    //MARK: - Reducer
    public func reduce(_ state: inout State, action: Action) -> AnyPublisher<Action, Never> {
        switch action {
        case let .setBreeds(breeds):
            state.breeds = breeds
            
        case let .didSelectBreedAt(index):
            if index < state.breeds.count {
                state.selectedBreed = state.breeds[index]
            }
            
        }
        return empty()
    }
    
    //MARK: - Preview store
    static let previewStore = Store(
        state: Self.State(),
        reducer: Self()
    )
}
