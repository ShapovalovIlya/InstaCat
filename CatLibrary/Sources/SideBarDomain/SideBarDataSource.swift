//
//  SideBarDataSource.swift
//  
//
//  Created by Илья Шаповалов on 19.09.2023.
//

import Cocoa
import Models

final class SideBarDataSource: NSCollectionViewDiffableDataSource<Int, String> {
    
    //MARK: - init(_:)
    init(collectionView: NSCollectionView) {
        super.init(collectionView: collectionView) { collectionView, indexPath, title in
            let item = collectionView.makeItem(
                withIdentifier: BreedItem.identifier,
                for: indexPath
            ) as? BreedItem
                    
            item?.setText(title)
            return item
        }
    }
    
    //MARK: - Public methods
    func reload(with breeds: [Breed]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])
        snapshot.appendItems(breeds.map(\.name), toSection: 0)
        apply(snapshot)
    }
}
