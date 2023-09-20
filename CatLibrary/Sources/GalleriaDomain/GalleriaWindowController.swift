//
//  GalleriaWindowController.swift
//  
//
//  Created by Илья Шаповалов on 20.09.2023.
//

import AppKit
import OSLog

public final class GalleriaWindowController: NSWindowController {
    //MARK: - Private properties
    private let logger: Logger?
    
    //MARK: - init(_:)
    init(logger: Logger? = nil) {
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
        
    }
    
    //MARK: - Public methods
    public override func showWindow(_ sender: Any?) {
        logger?.log(level: .debug, domain: self, event: #function)
        window?.makeKeyAndOrderFront(sender)
        window?.center()
    }
}
