//
//  NSWindow+.swift
//
//
//  Created by Илья Шаповалов on 11.09.2023.
//

import AppKit

public extension NSWindow {
    func addStyleMasks(_ styleMasks: NSWindow.StyleMask...) {
        styleMasks.forEach { mask in
            styleMask.insert(mask)
        }
    }
}
