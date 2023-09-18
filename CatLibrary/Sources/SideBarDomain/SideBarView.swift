//
//  SideBarView.swift
//  
//
//  Created by Илья Шаповалов on 12.09.2023.
//

import Cocoa
import Extensions

protocol SideBarViewProtocol: NSView {
    var collection: NSCollectionView { get }
}

final class SideBarView: NSView, SideBarViewProtocol {
    //MARK: - Public properties
    public let collection: NSCollectionView = .plain()
    
    //MARK: - Private properties
    private let scroll: NSScrollView = .plain()
    
    //MARK: - init(_:)
    public init() {
        super.init(frame: NSMakeRect(0, 0, 200, 400))
        
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
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: .combined(fractionalWidth: 1, estimatedHeight: 50),
            subitem: .fractional(width: 1, height: 1),
            count: 1
        )
        
        let section = NSCollectionLayoutSection(group: group)
        return NSCollectionViewCompositionalLayout(section: section)
    }
}
