//
//  ContentDataSource.swift
//  
//
//  Created by Илья Шаповалов on 19.09.2023.
//

import Cocoa
import GalleriaDomain

final class ContentDataSource: NSCollectionViewDiffableDataSource<Section, Item> {
    //MARK: - ItemProvider
    private let itemProvider: ItemProvider = { collectionView, indexPath, item in
        switch item {
        case let .title(breedImage):
            let titleItem = collectionView.makeItem(
                withIdentifier: CatImageItem.identifier,
                for: indexPath
            ) as? CatImageItem
            
            titleItem?.configure(with: breedImage)
            return titleItem
            
        case let .description(description):
            let descriptionItem = collectionView.makeItem(
                withIdentifier: DescriptionItem.identifier,
                for: indexPath
            ) as? DescriptionItem
            
            descriptionItem?.configure(with: description)
            return descriptionItem
            
        case let .detail(detail):
            let detailItem = collectionView.makeItem(
                withIdentifier: DetailItem.identifier,
                for: indexPath
            ) as? DetailItem
            
            detailItem?.configure(with: detail)
            return detailItem
            
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
        self.supplementaryViewProvider = makeSupplementary()
    }
    
    //MARK: - Public methods
    func reload(with breedDetail: BreedDetail) {
        let snapshot = makeSnapshot(with: breedDetail)
        apply(snapshot)
    }
    
}

private extension ContentDataSource {
    //MARK: - NSDiffableDataSourceSnapshot
    func makeSnapshot(with breedDetail: BreedDetail) -> NSDiffableDataSourceSnapshot<Section, Item> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(Section.allCases)
        
        if let title = breedDetail.titleImage.map(Item.title) {
            snapshot.appendItems(
                [title],
                toSection: .title
            )
        }
        snapshot.appendItems(
            [Item.description(breedDetail.description)],
            toSection: .description
        )
        snapshot.appendItems(
            breedDetail.details.map(Item.detail),
            toSection: .details
        )
        snapshot.appendItems(
            breedDetail.properties.map(Item.property),
            toSection: .properties
        )
        snapshot.appendItems(
            breedDetail.links.map(Item.link) ,
            toSection: .links
        )
        return snapshot
    }
    
    //MARK: - SupplementaryViewProvider
    func makeSupplementary() -> NSCollectionViewDiffableDataSource<Section, Item>.SupplementaryViewProvider {
        { collectionView, kind, indexPath in
            let header = collectionView.makeSupplementaryView(
                ofKind: NSCollectionView.elementKindSectionHeader,
                withIdentifier: HeaderView.identifier,
                for: indexPath
            ) as? HeaderView
            
            switch Section(rawValue: indexPath.section) {
            case .details:
                header?.set(title: "Details")
                
            case .properties:
                header?.set(title: "Properties")
                
            case .links:
                header?.set(title: "Links")
                
            default:
                return nil
            }
            return header
        }
    }
}
