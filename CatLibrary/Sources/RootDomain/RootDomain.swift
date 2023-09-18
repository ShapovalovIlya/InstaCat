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
        
        public init() {}
    }
    
    //MARK: - Action
    public enum Action: Equatable {
       
        public static func == (lhs: RootDomain.Action, rhs: RootDomain.Action) -> Bool {
            String(describing: lhs) == String(describing: rhs)
        }
    }
    
    //MARK: - Dependencies
    
    //MARK: - init(_:)
    public init() {}
    
    //MARK: - Reducer
    public func reduce(_ state: inout State, action: Action) -> AnyPublisher<Action, Never> {
        
        return empty()
    }
}

private extension RootDomain {
   
}
