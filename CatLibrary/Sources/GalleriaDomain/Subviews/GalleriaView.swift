//
//  GalleriaView.swift
//  
//
//  Created by Илья Шаповалов on 20.09.2023.
//

import Cocoa
import Extensions

protocol GalleriaViewProtocol: NSView {
    var collectionView: NSCollectionView { get }
}

final class GalleriaView: NSView, GalleriaViewProtocol {
    //MARK: - Public properties
    let collectionView: NSCollectionView = .plain(isSelectable: false)
    
    //MARK: - Private properties
    private let scrollView: NSScrollView = .plain()
    
    //MARK: - init(_:)
    init() {
        super.init(frame: NSMakeRect(0, 0, 400, 400))
        collectionView.collectionViewLayout = makeLayout()
        scrollView.documentView = collectionView
        scrollView.contentInsets = .init(top: 0, left: 0, bottom: 40, right: 0)
        addSubview(scrollView)
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension GalleriaView {
    //MARK: - Private methods
    func makeLayout() -> NSCollectionViewCompositionalLayout {
        let section: NSCollectionLayoutSection = .sectionLayout(
            item: .fractional(width: 1, height: 1),
            group: .fractional(width: 1, height: 0.8)
        )
        return .init(section: section)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            scrollView.leftAnchor.constraint(equalTo: leftAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
