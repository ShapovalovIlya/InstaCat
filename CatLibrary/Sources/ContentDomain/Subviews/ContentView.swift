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
    var galleriaButton: NSButton { get }
}

final class ContentView: NSView, ContentViewProtocol {
    //MARK: - Public properties
    let collection: NSCollectionView = .plain(isSelectable: true)
    let galleriaButton: NSButton = makeButton()
    
    //MARK: - Private properties
    private let scroll: NSScrollView = .plain()
    
    //MARK: - init(_:)
    init() {
        super.init(frame: NSMakeRect(0, 0, 600, 600))
        
        collection.collectionViewLayout = makeCollectionLayout()
        scroll.contentInsets = .init(top: 0, left: 0, bottom: 40, right: 0)
        scroll.documentView = collection
        addSubviews(
            scroll,
            galleriaButton
        )
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
                return .vertical(
                    item: .fractional(width: 1, height: 1),
                    group: .fractional(width: 1, height: 0.5),
                    insets: .init(top: 20, leading: 0, bottom: 10, trailing: 0)
                )
                
            case .description:
                return .vertical(
                    item: .fractional(width: 1, height: 1),
                    group: .fractional(width: 1, height: 0.3)
                )
                
            case .properties:
                return .vertical(
                    item: .fractional(width: 1, height: 1),
                    group: .combined(fractionalWidth: 1, estimatedHeight: 50)
                )
                
            case .links, .details:
                return .vertical(
                    item: .fractional(width: 1, height: 1),
                    group: .combined(fractionalWidth: 0.3, estimatedHeight: 60),
                    supplementary: [.header(height: 44)],
                    scrollBehavior: .continuous
                )
                
            case .none:
                return nil
            }
        }
    }
    
    static func makeButton() -> NSButton {
        let button = NSButton()
        button.title = "Galleria"
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            // scroll
            scroll.topAnchor.constraint(equalTo: topAnchor),
            scroll.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            scroll.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            scroll.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            // button
            galleriaButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            galleriaButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20)
        ])
    }
}
