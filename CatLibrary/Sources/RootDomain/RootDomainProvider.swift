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
import Dependencies

import Models

@dynamicMemberLookup
public struct RootDomainProvider {
    //MARK: - Public properties
    public let store: StoreOf<RootDomain>
    
    //MARK: - Private properties
    private let windowController: RootWindowController
    private let repository: Repository
    
    //MARK: -  init(_:)
    public init() {
        self.repository = .init(logger: Logger.system)
        let reducer = RootDomain(getRequest: repository.getRequest)
        self.store = Store(
            state: RootDomain.State(),
            reducer: reducer
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
