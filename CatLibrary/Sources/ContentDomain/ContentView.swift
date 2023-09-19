//
//  ContentView.swift
//  
//
//  Created by Илья Шаповалов on 18.09.2023.
//

import Cocoa
import Extensions

protocol ContentViewProtocol: NSView {
    var collection: NSCollectionView { get }
}

final class ContentView: NSView, ContentViewProtocol {
    //MARK: - Public properties
    let collection: NSCollectionView = .plain(isSelectable: false)
    
    //MARK: - Private properties
    private let scroll: NSScrollView = .plain()
    
    //MARK: - init(_:)
    init() {
        super.init(frame: NSMakeRect(0, 0, 600, 600))
        
        collection.collectionViewLayout = makeCollectionLayout()
        scroll.documentView = collection
        addSubview(scroll)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life cycle
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        setConstraints()
    }
    
}

private extension ContentView {
    //MARK: - Private methods
    func makeCollectionLayout() -> NSCollectionViewCompositionalLayout {
        .init { sectionIndex, environment in
            switch Section(rawValue: sectionIndex) {
            case .title:
                return self.makeTitleSection()
                
            case .description:
                return self.makeDescriptionSection()
                
            case .details:
                return self.makeDetailsSection()
                
            case .properties:
                return self.makePropertiesSection()
                
            case .links:
                return self.makeLinkSection()
                
            case .none:
                return nil
            }
        }
    }
    
    func makeTitleSection() -> NSCollectionLayoutSection {
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: .combined(fractionalWidth: 1, estimatedHeight: 150),
            subitem: .fractional(width: 1, height: 1),
            count: 1
        )
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 20, leading: 0, bottom: 10, trailing: 0)
        return section
    }
    
    func makeDescriptionSection() -> NSCollectionLayoutSection {
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: .fractional(width: 1, height: 0.3),
            subitem: .fractional(width: 1, height: 1),
            count: 1
        )
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        return section
    }
    
    func makeDetailsSection() -> NSCollectionLayoutSection {
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: .combined(fractionalWidth: 1, estimatedHeight: 44),
            subitem: .fractional(width: 1, height: 1),
            count: 1
        )
        return .init(group: group)
    }
    
    func makePropertiesSection() -> NSCollectionLayoutSection {
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: .combined(fractionalWidth: 1, estimatedHeight: 44),
            subitem: .fractional(width: 1, height: 1),
            count: 1
        )
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
        return section
    }
    
    func makeLinkSection() -> NSCollectionLayoutSection {
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: .combined(fractionalWidth: 1, estimatedHeight: 44),
            subitem: .fractional(width: 0.25, height: 1),
            count: 1
        )
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
        return section
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scroll.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            scroll.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            scroll.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor)
        ])
    }
}
