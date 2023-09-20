//
//  GalleriaDataSource.swift
//  
//
//  Created by Илья Шаповалов on 20.09.2023.
//

import Cocoa
import AppKit
import Models

final class GalleriaDataSource: NSCollectionViewDiffableDataSource<Int, BreedImage> {
    private let itemProvider: ItemProvider = { collectionView, indexPath, breedImage in
        let imageItem = collectionView.makeItem(
            withIdentifier: CatImageItem.identifier,
            for: indexPath
        ) as? CatImageItem
        
        imageItem?.configure(with: breedImage)
        return imageItem
    }
    
    //MARK: - init(_:)
    init(collectionView: NSCollectionView) {
        super.init(
            collectionView: collectionView,
            itemProvider: itemProvider
        )
    }
    
    //MARK: - Public methods
    func reload(with images: [BreedImage]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, BreedImage>()
        snapshot.appendSections([0])
        snapshot.appendItems(
            images,
            toSection: 0
        )
        apply(snapshot)
    }
}
