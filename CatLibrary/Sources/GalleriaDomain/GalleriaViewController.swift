//
//  GalleriaViewController.swift
//  
//
//  Created by Илья Шаповалов on 20.09.2023.
//

import Cocoa
import OSLog
import SwiftUDF
import Combine

final class GalleriaViewController: NSViewController {
    private let galleriaView: GalleriaViewProtocol
    private let store: StoreOf<GalleriaDomain>
    private let logger: Logger?
    private var cancellable: Set<AnyCancellable> = .init()
    private lazy var dataSource = GalleriaDataSource(collectionView: galleriaView.collectionView)

    //MARK: - init(_:)
    init(
        galleriaView: GalleriaViewProtocol,
        store: StoreOf<GalleriaDomain>,
        logger: Logger?
    ) {
        self.galleriaView = galleriaView
        self.store = store
        self.logger = logger
        super.init(nibName: nil, bundle: nil)
        logger?.log(level: .debug, domain: self, event: #function)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        cancellable.removeAll()
        logger?.log(level: .debug, domain: self, event: #function)
    }
    
    //MARK: - Life Cycle
    override func loadView() {
        view = galleriaView
        setup(galleriaView.collectionView)
        
        logger?.log(level: .debug, domain: self, event: #function)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        store.$state
            .map(\.images)
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: dataSource.reload(with:))
            .store(in: &cancellable)
        
        logger?.log(level: .debug, domain: self, event: #function)
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        store.send(.viewWillAppear)
        logger?.log(level: .debug, domain: self, event: #function)
    }
}

extension GalleriaViewController: NSCollectionViewDelegate {
    func collectionView(
        _ collectionView: NSCollectionView,
        willDisplay item: NSCollectionViewItem,
        forRepresentedObjectAt indexPath: IndexPath
    ) {
        store.send(.willDisplayImageAt(indexPath.item))
    }
}

private extension GalleriaViewController {
    func setup(_ collectionView: NSCollectionView) {
        collectionView.register(
            CatImageItem.self,
            forItemWithIdentifier: CatImageItem.identifier
        )
        collectionView.dataSource = dataSource
        collectionView.delegate = self
    }
}
