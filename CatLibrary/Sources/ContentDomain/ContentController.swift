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
import GalleriaDomain

public final class ContentController: NSViewController {
    //MARK: - Private properties
    private let store: StoreOf<ContentDomain>
    private let contentView: ContentViewProtocol
    private var cancellable: Set<AnyCancellable> = .init()
    private var logger: Logger?
    
    private lazy var dataSource: ContentDataSource = .init(collectionView: contentView.collection)
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
    public override func loadView() {
        view = contentView
        setup(collectionView: contentView.collection)
        logger?.log(level: .debug, domain: self, event: #function)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        store.$state
            .compactMap(\.breedDetail)
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: dataSource.reload(with:))
            .store(in: &cancellable)
        
        contentView.galleriaButton.target = self
        contentView.galleriaButton.action = #selector(galleriaButtonTap)
        
        logger?.log(level: .debug, domain: self, event: #function)
    }
    
    public override func viewDidDisappear() {
        super.viewDidDisappear()
        store.dispose()
        logger?.log(level: .debug, domain: self, event: #function)
    }
    
    @objc func galleriaButtonTap() {
        guard let breedId = store.state.breed?.id else {
            return
        }
        let provider = GalleriaProvider(breedId: breedId)
        provider.windowController.showWindow(nil)
    }
}

//MARK: - NSCollectionViewDelegate
extension ContentController: NSCollectionViewDelegate {
    public func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        collectionView.deselectItems(at: indexPaths)
        guard 
            let indexPath = indexPaths.first,
            Section(rawValue: indexPath.section) == .links
        else {
            return
        }
        store.send(.didSelectLinkAt(indexPath.item))
    }
}

private extension ContentController {
    //MARK: - Private methods
    func setup(collectionView: NSCollectionView) {
        collectionView.register(
            CatImageItem.self,
            forItemWithIdentifier: CatImageItem.identifier
        )
        collectionView.register(
            DescriptionItem.self,
            forItemWithIdentifier: DescriptionItem.identifier
        )
        collectionView.register(
            DetailItem.self,
            forItemWithIdentifier: DetailItem.identifier
        )
        collectionView.register(
            PropertyItem.self,
            forItemWithIdentifier: PropertyItem.identifier
        )
        collectionView.register(
            LinkItem.self,
            forItemWithIdentifier: LinkItem.identifier
        )
        collectionView.register(
            HeaderView.self,
            forSupplementaryViewOfKind: NSCollectionView.elementKindSectionHeader,
            withIdentifier: HeaderView.identifier
        )
        collectionView.dataSource = self.dataSource
        collectionView.delegate = self
    }
    
}
