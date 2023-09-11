//
//  File.swift
//  
//
//  Created by Илья Шаповалов on 11.09.2023.
//

import AppKit

@dynamicMemberLookup
public struct RootDomainProvider {
    private let window: RootWindow
    private let windowController: RootWindowController
    
    //MARK: -  init(_:)
    public init() {
        self.window = RootWindow()
        self.windowController = RootWindowController(rootWindow: window)
    }
    
    //MARK: - Subscript
    public subscript<V>(dynamicMember keyPath: KeyPath<RootWindowController, V>) -> V {
        windowController[keyPath: keyPath]
    }
    
    public func showWindow() {
        windowController.showWindow(nil)
    }
}
