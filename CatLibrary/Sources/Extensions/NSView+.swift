//
//  NSView+.swift
//
//
//  Created by Илья Шаповалов on 18.09.2023.
//

import AppKit

public extension NSView {
    func addSubviews(_ views: NSView...) {
        views.forEach(addSubview(_:))
    }
}
