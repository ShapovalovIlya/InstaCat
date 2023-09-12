//
//  RootWindowController.swift
//  
//
//  Created by Илья Шаповалов on 11.09.2023.
//

import Cocoa
import AppKit
import OSLog
import Extensions
import SwiftUDF

public final class RootWindowController: NSWindowController {
    //MARK: - Public properties
    
    //MARK: - Private properties
    private let store: StoreOf<RootDomain>
    private let sideBarController = NSViewController()
    private let contentController = NSViewController()
    private var splitViewController: NSSplitViewController?
    
    //MARK: - init(_:)
    public init(store: StoreOf<RootDomain>) {
        self.store = store
        super.init(window: .init())
        
        Logger.viewCycle.log(level: .debug, domain: self, event: #function)
        loadWindow()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        Logger.viewCycle.debug(#function)
    }
    
    //MARK: - Life Cycle
    public override func loadWindow() {
        window?.windowController = self
        configure(window: window)
        
        let toolbar = NSToolbar()
        toolbar.displayMode = .iconOnly
        toolbar.delegate = self
        
        window?.toolbar = toolbar
        
        let sideBarView = NSView()
        sideBarView.wantsLayer = true
        sideBarView.layer?.backgroundColor = NSColor.red.cgColor
        sideBarView.setFrameSize(.init(width: 200, height: 400))
        
        let contentBarView = NSView()
        contentBarView.wantsLayer = true
        contentBarView.layer?.backgroundColor = NSColor.green.cgColor
        contentBarView.setFrameSize(.init(width: 400, height: 400))
        
        sideBarController.view = sideBarView
        contentController.view = contentBarView
        
        splitViewController = NSSplitViewController(
            sideBarController: sideBarController,
            contentController: contentController
        )
        
        contentViewController = splitViewController
        window?.contentView = splitViewController?.splitView
        
        Logger.viewCycle.log(level: .debug, domain: self, event: #function)
        
        windowWillLoad()
    }
    
    public override func windowWillLoad() {
        Logger.viewCycle.log(level: .debug, domain: self, event: #function)
        windowDidLoad()
    }

    public override func windowDidLoad() {
        Logger.viewCycle.log(level: .debug, domain: self, event: #function)
    }
    
    //MARK: - Public methods
    public override func showWindow(_ sender: Any?) {
        window?.makeKeyAndOrderFront(sender)
        window?.center()
    }

}

//MARK: - NSToolbarDelegate
extension RootWindowController: NSToolbarDelegate {
    public func toolbar(
        _ toolbar: NSToolbar,
        itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier,
        willBeInsertedIntoToolbar flag: Bool
    ) -> NSToolbarItem? {
       NSToolbarItem(itemIdentifier: itemIdentifier)
    }
    
    public func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        [
            .toggleSidebar,
        ]
    }
    
    public func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        [
            .toggleSidebar
        ]
    }
    
}

private extension RootWindowController {
    //MARK: - Private methods
    func configure(window: NSWindow?) {
        window?.title = "InstaCat"
        window?.addStyleMasks(
            .closable,
            .miniaturizable,
            .resizable,
            .titled
        )
        window?.toolbarStyle = .unifiedCompact
    }
}
