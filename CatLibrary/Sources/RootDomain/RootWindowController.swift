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
import SideBarDomain

public final class RootWindowController: NSWindowController {
    //MARK: - Public properties
    
    //MARK: - Private properties
    private let store: StoreOf<RootDomain>
    private let contentController = NSViewController()
    private var splitViewController: NSSplitViewController?
    private lazy var sideBarProvider = SideBarProvider()
    
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
               
        let contentBarView = NSView()
        contentBarView.wantsLayer = true
        contentBarView.layer?.backgroundColor = NSColor.green.cgColor
        contentBarView.setFrameSize(.init(width: 400, height: 400))
        
        contentController.view = contentBarView
        
        splitViewController = NSSplitViewController(
            sideBarController: sideBarProvider.viewController,
            contentController: contentController
        )
        
        contentViewController = splitViewController
        window?.contentView = splitViewController?.splitView
        
        Logger.viewCycle.log(level: .debug, domain: self, event: #function)
        
        windowDidLoad()
    }

    public override func windowDidLoad() {
        store.send(.windowDidLoad)
        
        Logger.viewCycle.log(level: .debug, domain: self, event: #function)
    }
    
    //MARK: - Public methods
    public override func showWindow(_ sender: Any?) {
        window?.makeKeyAndOrderFront(sender)
        window?.center()
    }
    
    @objc func refreshBreedContent() {
        print(#function)
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
            .refresh
        ]
    }
    
    public func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        [
            .toggleSidebar,
            .refresh
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
