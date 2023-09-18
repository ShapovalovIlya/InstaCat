//
//  NSCollectionLayoutSize.swift
//  
//
//  Created by Илья Шаповалов on 18.09.2023.
//

import AppKit

public extension NSCollectionLayoutSize {
    static func combined(
        fractionalWidth: CGFloat,
        estimatedHeight: CGFloat
    ) -> NSCollectionLayoutSize {
        .init(
            widthDimension: .fractionalWidth(fractionalWidth),
            heightDimension: .estimated(estimatedHeight)
        )
    }
}
