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

public struct RootDomain: ReducerDomain {
    //MARK: - State
    public struct State {
        
    }
    
    //MARK: - Action
    public enum Action: Equatable {
        
    }
    
    //MARK: - Dependencies
    
    //MARK: - init(_:)
    
    //MARK: - Reducer
    public func reduce(_ state: inout State, action: Action) -> AnyPublisher<Action, Never> {
        
        return empty()
    }
}
