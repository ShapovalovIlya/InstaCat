//
//  NSScrollView.swift
//  
//
//  Created by Илья Шаповалов on 18.09.2023.
//

import AppKit

public extension NSScrollView {
    static func plain(scrollersAlpha: CGFloat = 0) -> NSScrollView {
        let scroll = NSScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.drawsBackground = false
        scroll.horizontalScroller?.alphaValue = scrollersAlpha
        scroll.verticalScroller?.alphaValue = scrollersAlpha
        return scroll
    }
}
