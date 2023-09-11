//
//  AppDelegate.swift
//  InstaCat
//
//  Created by Илья Шаповалов on 09.09.2023.
//

import Cocoa
import Extensions
import OSLog

public final class AppDelegate: NSObject, NSApplicationDelegate {

    //MARK: - init(_:)
    public override init() {
        super.init()
        
        Logger.system.logging(level: .debug, domain: self, event: #function)
    }
    
    //MARK: - Public methods
    public func applicationDidFinishLaunching(_ aNotification: Notification) {
        
    }

    public func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    public func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }


}

