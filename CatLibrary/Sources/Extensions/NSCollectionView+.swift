//
//  NSCollectionView.swift
//  
//
//  Created by Илья Шаповалов on 18.09.2023.
//

import AppKit

public extension NSCollectionView {
    static func plain(isSelectable: Bool = true) -> NSCollectionView {
        let collection = NSCollectionView()
        collection.isSelectable = isSelectable
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }
}
