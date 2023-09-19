//
//  ContentDataSource.swift
//  
//
//  Created by Илья Шаповалов on 19.09.2023.
//

import Cocoa

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
        var titles: [Item] = .init()
        if let image = breedDetail.titleImage {
            titles.append(Item.title(image))
            snapshot.appendItems(
                titles,
                toSection: .title
            )
        }
        snapshot.appendItems(
            [Item.description(breedDetail.description)],
            toSection: .description
        )
//        snapshot.appendItems(
//            breedDetail.details.map(Item.detail),
//            toSection: .details
//        )
        snapshot.appendItems(
            breedDetail.properties.map(Item.property),
            toSection: .properties
        )
        snapshot.appendItems(
            breedDetail.links.map(Item.link),
            toSection: .links
        )
        return snapshot
    }
    
    //MARK: - SupplementaryViewProvider
    func makeSupplementary() -> NSCollectionViewDiffableDataSource<Section, Item>.SupplementaryViewProvider {
        { collectionView, kind, indexPath in
            switch Section(rawValue: indexPath.section) {
            case .title:
                return nil
            case .description:
                return nil
                
            case .details:
                return nil
                
            case .properties:
                return nil
                
            case .links:
                return nil
                
            case .none:
                return nil
            }
        }
    }
}
