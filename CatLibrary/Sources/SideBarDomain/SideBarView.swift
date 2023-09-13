//
//  SideBarView.swift
//  
//
//  Created by Илья Шаповалов on 12.09.2023.
//

import Cocoa

public protocol SideBarViewProtocol: NSView {
    var collection: NSCollectionView { get }
}

public class SideBarView: NSView, SideBarViewProtocol {
    //MARK: - Public properties
    public let collection: NSCollectionView = makeCollectionView()
    
    //MARK: - Private properties
    private let scroll: NSScrollView = makeScrollView()
    
    //MARK: - init(_:)
    public init() {
        super.init(frame: .init(x: 0, y: 0, width: 200, height: 400))
        
        collection.collectionViewLayout = makeLayout()
        scroll.documentView = collection
        addSubview(scroll)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - draw(_:)
    public override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        setConstraints()
    }
    
}

private extension SideBarView {
    //MARK: - Private methods
    func setConstraints() {
        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: topAnchor),
            scroll.leftAnchor.constraint(equalTo: leftAnchor),
            scroll.rightAnchor.constraint(equalTo: rightAnchor),
            scroll.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func makeLayout() -> NSCollectionViewLayout {
        let item = makeItemWithDimensions(width: 1, height: 1)
        let group = makeGroupWithDimensions(
            width: 1,
            height: 0.1,
            items: item
        )
        let section = NSCollectionLayoutSection(group: group)
        return NSCollectionViewCompositionalLayout(section: section)
    }
    
    func makeGroupWithDimensions(
        width: CGFloat,
        height: CGFloat,
        items: NSCollectionLayoutItem...
    ) -> NSCollectionLayoutGroup {
        let size = makeFractionalSize(width: width, height: height)
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: size,
            subitems: items)
        return group
    }
    
    func makeItemWithDimensions(
        width: CGFloat,
        height: CGFloat
    ) -> NSCollectionLayoutItem {
        let size = makeFractionalSize(width: width, height: height)
        return NSCollectionLayoutItem(layoutSize: size)
    }
    
    func makeFractionalSize(
        width: CGFloat,
        height: CGFloat
    ) -> NSCollectionLayoutSize {
        NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(width),
            heightDimension: .fractionalHeight(height)
        )
    }
    
    static func makeCollectionView() -> NSCollectionView {
        let collection = NSCollectionView()
        collection.isSelectable = true
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }
    
    static func makeScrollView() -> NSScrollView {
        let scroll = NSScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.drawsBackground = false
        scroll.horizontalScroller?.alphaValue = 0
        scroll.verticalScroller?.alphaValue = 0
        return scroll
    }
}
