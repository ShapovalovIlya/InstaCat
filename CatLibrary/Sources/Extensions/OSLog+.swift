//
//  OSLog+.swift
//
//
//  Created by Илья Шаповалов on 09.09.2023.
//

import OSLog

public extension Logger {
    private static let subsystem = Bundle.main.bundleIdentifier!
    static let viewCycle = Self(subsystem: subsystem, category: "viewCycle")
    static let system = Self(subsystem: subsystem, category: "system")
    
    func log(level: OSLogType, domain: Any, event: String) {
        self.log(
            level: level,
            "\(String(describing: domain)): \(event)"
        )
    }
}
