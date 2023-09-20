//
//  NSCollectionLayoutSupplementaryItem+.swift
//
//
//  Created by Илья Шаповалов on 20.09.2023.
//

import AppKit

public extension NSCollectionLayoutSupplementaryItem {
    static func header(
        height: CGFloat,
        alignment: NSRectAlignment = .topLeading
    ) -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(
            layoutSize: .combined(fractionalWidth: 1, estimatedHeight: height),
            elementKind: NSCollectionView.elementKindSectionHeader,
            alignment: alignment
        )
    }
}
