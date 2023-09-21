//
//  GalleriaWindowController.swift
//  
//
//  Created by Илья Шаповалов on 20.09.2023.
//

import AppKit
import OSLog
import Extensions

public final class GalleriaWindowController: NSWindowController {
    //MARK: - Private properties
    private let viewController: GalleriaViewController
    private let logger: Logger?
    
    //MARK: - init(_:)
    init(
        viewController: GalleriaViewController,
        logger: Logger? = nil
    ) {
        self.viewController = viewController
        self.logger = logger
        super.init(window: .init())
        
        self.logger?.log(level: .debug, domain: self, event: #function)
        loadWindow()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        logger?.log(level: .debug, domain: self, event: #function)
    }
    
    //MARK: - Life cycle
    public override func loadWindow() {
        setupWindow()
        contentViewController = viewController
        window?.contentView = viewController.view
        
        logger?.log(level: .debug, domain: self, event: #function)
    }
    
    //MARK: - Public methods
    public override func showWindow(_ sender: Any?) {
        logger?.log(level: .debug, domain: self, event: #function)
        window?.makeKeyAndOrderFront(sender)
        window?.center()
    }
}

//MARK: - Private methods
private extension GalleriaWindowController {
    func setupWindow() {
        window?.title = "Galleria"
        window?.addStyleMasks(
            .closable,
            .miniaturizable,
            .resizable,
            .titled,
            .fullSizeContentView
        )
        window?.titlebarSeparatorStyle = .shadow
    }
}
