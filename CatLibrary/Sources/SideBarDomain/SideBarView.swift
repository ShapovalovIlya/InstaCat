//
//  SideBarView.swift
//  
//
//  Created by Илья Шаповалов on 12.09.2023.
//

import Cocoa
import Extensions

public protocol SideBarViewProtocol: NSView {
    var collection: NSCollectionView { get }
}

public class SideBarView: NSView, SideBarViewProtocol {
    //MARK: - Public properties
    public let collection: NSCollectionView = .plain()
    
    //MARK: - Private properties
    private let scroll: NSScrollView = .plain()
    
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
        let item: NSCollectionLayoutItem = .fractional(width: 1, height: 1)
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
        let size: NSCollectionLayoutSize = .fractional(width: width, height: height)
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: size,
            subitems: items)
        return group
    }
    
}
