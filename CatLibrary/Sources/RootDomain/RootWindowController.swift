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
import Combine
import ContentDomain

public final class RootWindowController: NSWindowController {
    //MARK: - Private properties
    private var logger: Logger?
    private var cancellable: Set<AnyCancellable> = .init()
    
    private var splitViewController: NSSplitViewController?
    
    private lazy var sideBarProvider = SideBarProvider()
    private lazy var contentProvider = ContentProvider()
    
    private lazy var sharedSideBarState = sideBarProvider.store.$state.share().eraseToAnyPublisher()
    
    //MARK: - init(_:)
    public init(logger: Logger? = nil) {
        self.logger = logger
        super.init(window: .init())
        
        logger?.log(level: .debug, domain: self, event: #function)
        loadWindow()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        cancellable.removeAll()
        logger?.log(level: .debug, domain: self, event: #function)
    }
    
    //MARK: - Life Cycle
    public override func loadWindow() {
        configure(window: window)
        window?.toolbar = makeToolbar()
        
        splitViewController = NSSplitViewController(
            sideBarController: sideBarProvider.viewController,
            contentController: contentProvider.viewController
        )
        
        contentViewController = splitViewController
        window?.contentView = splitViewController?.splitView
        
        bind(
            sharedSideBarState,
            to: contentProvider.store
        )(&cancellable)
        
        sharedSideBarState
            .map(\.dataLoadingStatus)
            .removeDuplicates()
            .sink { _ in }
            .store(in: &cancellable)
        
        logger?.log(level: .debug, domain: self, event: #function)
        windowDidLoad()
    }

    public override func windowDidLoad() {
        super.windowDidLoad()
        
        logger?.log(level: .debug, domain: self, event: #function)
    }
    
    //MARK: - Public methods
    public override func showWindow(_ sender: Any?) {
        logger?.log(level: .debug, domain: self, event: #function)
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
            .toggleSidebar
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
    func bind(
        _ state: AnyPublisher<SideBarDomain.State, Never>,
        to store: StoreOf<ContentDomain>
    ) -> (inout Set<AnyCancellable>) -> Void {
        { cancellable in
            state
                .compactMap(\.selectedBreed)
                .removeDuplicates()
                .sink { store.send(.setBreed($0)) }
                .store(in: &cancellable)
        }
    }
    
    func configure(window: NSWindow?) {
        window?.windowController = self
        window?.title = "InstaCat"
        window?.addStyleMasks(
            .closable,
            .miniaturizable,
            .resizable,
            .titled,
            .fullSizeContentView
        )
        window?.toolbarStyle = .unifiedCompact
        window?.titlebarSeparatorStyle = .shadow
    }
    
    func makeToolbar() -> NSToolbar {
        let toolbar = NSToolbar()
        toolbar.displayMode = .iconOnly
        toolbar.delegate = self
        return toolbar
    }
}
