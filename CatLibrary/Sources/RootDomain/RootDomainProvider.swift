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

public struct RootDomainProvider {
    
    //MARK: - Private properties
    private let windowController: RootWindowController
    
    //MARK: -  init(_:)
    public init() {
        self.windowController = .init(logger: Logger.viewCycle)
    }
    
    public func showWindow() {
        windowController.showWindow(nil)
    }
}
