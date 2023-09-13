//
//  AppDelegate.swift
//  InstaCat
//
//  Created by Илья Шаповалов on 09.09.2023.
//

import Cocoa
import Extensions
import OSLog
import RootDomain
import AppKit

public final class AppDelegate: NSObject, NSApplicationDelegate {
    lazy var rootDomainProvider = RootDomainProvider()

    //MARK: - init(_:)
    public override init() {
        super.init()
        
        Logger.system.log(level: .debug, domain: self, event: #function)
    }
    
    //MARK: - Public methods
    public func applicationDidFinishLaunching(_ aNotification: Notification) {
        rootDomainProvider.showWindow()
        
    }

    public func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    public func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

    public static func main() {
        let delegate = AppDelegate()
        let app = NSApplication.shared

        app.delegate = delegate
        app.run()
    }
}

