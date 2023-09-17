//
//  File.swift
//  
//
//  Created by Илья Шаповалов on 11.09.2023.
//

import AppKit
import Extensions
import SwiftUDF
import Combine
import OSLog

import Models

@dynamicMemberLookup
public struct RootDomainProvider {
    //MARK: - Public properties
    public let store: StoreOf<RootDomain>
    
    //MARK: - Private properties
    private let windowController: RootWindowController
    
    //MARK: -  init(_:)
    public init() {
        let reducer = RootDomain(getRequest: { _ in
            Just([Breed.sample])
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        })
        self.store = Store(
            state: RootDomain.State(),
            reducer: reducer,
            logger: Logger.system
        )
        self.windowController = RootWindowController(
            store: store,
            logger: Logger.viewCycle
        )
    }
    
    //MARK: - Subscript
    public subscript<V>(dynamicMember keyPath: KeyPath<RootWindowController, V>) -> V {
        windowController[keyPath: keyPath]
    }
    
    public func showWindow() {
        windowController.showWindow(nil)
    }
}
