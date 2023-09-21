//
//  NSCollectionLayoutSection+.swift
//
//
//  Created by Илья Шаповалов on 20.09.2023.
//

import AppKit

public extension NSCollectionLayoutSection {
    static func vertical(
        item: NSCollectionLayoutItem,
        itemsCount: Int = 1,
        group: NSCollectionLayoutSize,
        supplementary: [NSCollectionLayoutBoundarySupplementaryItem] = .init(),
        scrollBehavior: NSCollectionLayoutSectionOrthogonalScrollingBehavior = .none,
        insets: NSDirectionalEdgeInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
    ) -> NSCollectionLayoutSection {
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: group,
            subitem: item,
            count: itemsCount
        )
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = insets
        section.boundarySupplementaryItems = supplementary
        section.orthogonalScrollingBehavior = scrollBehavior
        return section
    }
}
