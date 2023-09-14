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

@dynamicMemberLookup
public struct RootDomainProvider {
    public let store: StoreOf<RootDomain>
    
    //MARK: - Private properties
    private let windowController: RootWindowController
    
    //MARK: -  init(_:)
    public init() {
        self.store = Store(
            state: RootDomain.State(),
            reducer: RootDomain(breedsPublisher: { _ in Fail(error: URLError(.badURL)).eraseToAnyPublisher() })
        )
        self.windowController = RootWindowController(store: store)
    }
    
    //MARK: - Subscript
    public subscript<V>(dynamicMember keyPath: KeyPath<RootWindowController, V>) -> V {
        windowController[keyPath: keyPath]
    }
    
    public func showWindow() {
        windowController.showWindow(nil)
    }
}
