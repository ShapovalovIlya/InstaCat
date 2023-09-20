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
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension ContentView {
    //MARK: - Private methods
    func makeCollectionLayout() -> NSCollectionViewCompositionalLayout {
        .init { sectionIndex, environment in
            switch Section(rawValue: sectionIndex) {
            case .title:
                return .sectionLayout(
                    item: .fractional(width: 1, height: 1),
                    group: .combined(fractionalWidth: 1, estimatedHeight: 150),
                    insets: .init(top: 20, leading: 0, bottom: 10, trailing: 0)
                )
                
            case .description:
                return .sectionLayout(
                    item: .fractional(width: 1, height: 1),
                    group: .fractional(width: 1, height: 0.4)
                )
                
            case .details, .properties:
                return .sectionLayout(
                    item: .fractional(width: 1, height: 1),
                    group: .combined(fractionalWidth: 1, estimatedHeight: 44),
                    supplementary: [.header(height: 44)]
                )
                
            case .links:
                return .sectionLayout(
                    item: .fractional(width: 1, height: 1),
                    group: .combined(fractionalWidth: 1, estimatedHeight: 44),
                    supplementary: [.header(height: 44)]
                )
                
            case .none:
                return nil
            }
        }
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
