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

public final class RootWindowController: NSWindowController {
    //MARK: - Public properties
    
    //MARK: - Private properties
    private let store: StoreOf<RootDomain>
    private var logger: Logger?
    private var cancellable: Set<AnyCancellable> = .init()
    private let contentController = NSViewController()
    private var splitViewController: NSSplitViewController?
    
    private lazy var sharedState = store.$state.share().eraseToAnyPublisher()
    private lazy var sideBarProvider = SideBarProvider()
    
    //MARK: - init(_:)
    public init(
        store: StoreOf<RootDomain>,
        logger: Logger? = nil
    ) {
        self.store = store
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
        store.dispose()
        cancellable.removeAll()
        logger?.log(level: .debug, domain: self, event: #function)
    }
    
    //MARK: - Life Cycle
    public override func loadWindow() {
        configure(window: window)
        window?.toolbar = makeToolbar()
               
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
        
        sideBarProvider.store.$state
            .compactMap(\.selectedBreed)
            .removeDuplicates()
            .sink(receiveValue: { print($0.name) })
            .store(in: &cancellable)
        
 //       bind(sharedState, to: sideBarProvider.store)(&cancellable)
        
//        sharedState
//            .compactMap(\.selectedBreed)
//            .removeDuplicates()
//            .sink(receiveValue: { _ in })
//            .store(in: &cancellable)
        
        logger?.log(level: .debug, domain: self, event: #function)
        windowDidLoad()
    }

    public override func windowDidLoad() {
        super.windowDidLoad()
        
        logger?.log(level: .debug, domain: self, event: #function)
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
//    func bind(
//        _ state: AnyPublisher<RootDomain.State, Never>,
//        to store: StoreOf<SideBarDomain>
//    ) -> (inout Set<AnyCancellable>) -> Void {
//        { cancellable in
//            state
//                .map(\.breeds)
//                .removeDuplicates()
//                .sink { store.send(.setBreeds($0)) }
//                .store(in: &cancellable)
//        }
//    }
    
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
