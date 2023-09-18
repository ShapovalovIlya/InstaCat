//
//  NSCollectionLayoutItem.swift
//
//
//  Created by Илья Шаповалов on 18.09.2023.
//

import AppKit

public extension NSCollectionLayoutItem {
    static func fractional(
        width: CGFloat,
        height: CGFloat
    ) -> NSCollectionLayoutItem {
        let size: NSCollectionLayoutSize = .fractional(width: width, height: height)
        return NSCollectionLayoutItem(layoutSize: size)
    }
}
