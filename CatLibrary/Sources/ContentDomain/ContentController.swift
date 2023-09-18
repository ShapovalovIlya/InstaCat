//
//  ContentController.swift
//  
//
//  Created by Илья Шаповалов on 18.09.2023.
//

import Cocoa
import SwiftUDF
import Combine
import OSLog
import Extensions
import Models

final class ContentController: NSViewController {
    //MARK: - Private properties
    private let store: StoreOf<ContentDomain>
    private let contentView: ContentViewProtocol
    private var cancellable: Set<AnyCancellable> = .init()
    private var logger: Logger?
    
    private lazy var dataSource: NSCollectionViewDiffableDataSource<Section, Item> = .init(
        collectionView: contentView.collection,
        itemProvider: makeItemProvider()
    )
    //MARK: - init(_:)
    init(
        store: StoreOf<ContentDomain>,
        contentView: ContentViewProtocol,
        logger: Logger? = nil
    ) {
        self.store = store
        self.contentView = contentView
        self.logger = logger
        
        super.init(nibName: nil, bundle: nil)
        logger?.log(level: .debug, domain: self, event: #function)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - deinit
    deinit {
        cancellable.removeAll()
        logger?.log(level: .debug, domain: self, event: #function)
    }
    
    //MARK: - Life Cycle
    override func loadView() {
        view = contentView
        setup(collectionView: contentView.collection)
        logger?.log(level: .debug, domain: self, event: #function)
    }
    
    override func viewDidLoad() {
        
        logger?.log(level: .debug, domain: self, event: #function)
    }
    
    override func viewDidDisappear() {
        store.dispose()
        logger?.log(level: .debug, domain: self, event: #function)
    }
}

//MARK: - NSCollectionViewDelegate
extension ContentController: NSCollectionViewDelegate {
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        collectionView.deselectItems(at: indexPaths)
    }
}

private extension ContentController {
    //MARK: - Item
    enum Item: Hashable {
        case title(BreedImage)
        
    }
    
    //MARK: - Private methods
    func makeItemProvider() -> NSCollectionViewDiffableDataSource<Section, Item>.ItemProvider {
        { collectionView, indexPath, item in
            switch item {
            case let .title(breedImage):
                let item = collectionView.makeItem(
                    withIdentifier: .init(""),
                    for: indexPath)
                
                
                return item
            }
            
//            switch Section(rawValue: indexPath.section) {
//            case .title:
//                let item = collectionView.makeItem(
//                    withIdentifier: .init(""),
//                    for: indexPath)
//                
//                
//                return item
//            case .description:
//                return nil
//                
//            case .properties:
//                return nil
//                
//            case .links:
//                return nil
//                
//            case .none: return nil
//            }
        }
    }
    
    func setup(collectionView: NSCollectionView) {
        collectionView.dataSource = self.dataSource
        collectionView.delegate = self
    }
    
}

import SwiftUI
#Preview {
    ContentController(
        store: ContentDomain.previewStore,
        contentView: ContentView()
    )
}
