//
//  NSTextField.swift
//
//
//  Created by Илья Шаповалов on 18.09.2023.
//

import AppKit

public extension NSTextField {
    static func custom(
        font: NSFont,
        alignment: NSTextAlignment = .natural,
        numberOfLines: Int = 0
    ) -> NSTextField {
        let textField = NSTextField()
        textField.isSelectable = true
        textField.isEditable = false
        textField.isBezeled = false
        textField.drawsBackground = false
        textField.lineBreakStrategy = .hangulWordPriority
        textField.maximumNumberOfLines = numberOfLines
        textField.font = font
        textField.alignment = alignment
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
}
