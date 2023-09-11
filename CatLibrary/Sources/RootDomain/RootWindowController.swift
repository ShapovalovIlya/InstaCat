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

public final class RootWindowController: NSWindowController {
    //MARK: - Public properties
    public let rootWindow: RootWindowProtocol
    
    //MARK: - Private properties
    private let styleMasks: [NSWindow.StyleMask] = [.closable, .resizable]
    
    //MARK: - init(_:)
    public init(rootWindow: RootWindowProtocol) {
        self.rootWindow = rootWindow
        super.init(window: rootWindow)
        
        self.rootWindow.windowController = self
        Logger.viewCycle.log(level: .debug, domain: self, event: #function)
        
        loadWindow()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
    public override func loadWindow() {
        self.window = rootWindow
        
        setup(window: rootWindow)
        styleMasks.forEach { rootWindow.styleMask.insert($0) }
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
        rootWindow.makeKeyAndOrderFront(sender)
        rootWindow.center()
    }

}

private extension RootWindowController {
    //MARK: - Private methods
    func setup(window: NSWindow) {
        let size: CGSize = .init(width: 400, height: 400)
        let rect = NSRect(origin: .zero, size: size)
        window.setFrame(rect, display: true)
    }
}
