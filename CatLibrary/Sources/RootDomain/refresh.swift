//
//  File.swift
//  
//
//  Created by Илья Шаповалов on 14.09.2023.
//

import AppKit

extension NSToolbarItem.Identifier {
    static let refresh = NSToolbarItem.Identifier("refresh.rootDomain")
}

extension NSToolbarItem {
    static var refresh: NSToolbarItem {
        let item = NSToolbarItem(itemIdentifier: .refresh)
        item.image = NSImage(
            systemSymbolName: NSImage.refreshTemplateName,
            accessibilityDescription: "refresh button"
        )
        item.action = #selector(RootWindowController.refreshBreedContent)
        item.target = RootWindowController.self
        return item
    }
}
