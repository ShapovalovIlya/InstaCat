//
//  File.swift
//  
//
//  Created by Илья Шаповалов on 18.09.2023.
//

import AppKit

public extension NSCollectionLayoutSize {
    static func fractional(
        width: CGFloat,
        height: CGFloat
    ) -> NSCollectionLayoutSize {
        .init(
            widthDimension: .fractionalWidth(width),
            heightDimension: .fractionalHeight(height)
        )
    }
}
