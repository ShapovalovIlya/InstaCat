//
//  ContentDataSource.swift
//  
//
//  Created by Илья Шаповалов on 19.09.2023.
//

import Cocoa
import Models

final class ContentDataSource: NSCollectionViewDiffableDataSource<Section, Item> {
    //MARK: - ItemProvider
    private let itemProvider: ItemProvider = { collectionView, indexPath, item in
        switch item {
        case let .title(breedImage):
            let titleItem = collectionView.makeItem(
                withIdentifier: TitleItem.identifier,
                for: indexPath
            ) as? TitleItem
            
            titleItem?.configure(with: breedImage)
            return titleItem
            
        case let .description(description):
            let descriptionItem = collectionView.makeItem(
                withIdentifier: DescriptionItem.identifier,
                for: indexPath
            ) as? DescriptionItem
            
            descriptionItem?.configure(with: description)
            return descriptionItem
            
        case let .property(property):
            let propertyItem = collectionView.makeItem(
                withIdentifier: PropertyItem.identifier,
                for: indexPath
            ) as? PropertyItem
            
            propertyItem?.configure(with: property)
            return propertyItem
            
        case let .link(link):
            let linkItem = collectionView.makeItem(
                withIdentifier: LinkItem.identifier,
                for: indexPath
            ) as? LinkItem
            
            linkItem?.configure(with: link)
            return linkItem
        }
    }
    
    //MARK: - init(_:)
    init(collectionView: NSCollectionView) {
        super.init(collectionView: collectionView, itemProvider: itemProvider)
    }
    
    //MARK: - Public methods
    func reload(with breed: Breed) {
 //       apply(<#T##snapshot: NSDiffableDataSourceSnapshot<Hashable, Hashable>##NSDiffableDataSourceSnapshot<Hashable, Hashable>#>)
    }
    
    func reload(with breedImage: BreedImage) {
        
    }
}
