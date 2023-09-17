//
//  SideBarController.swift
//  
//
//  Created by Илья Шаповалов on 12.09.2023.
//

import Cocoa
import SwiftUDF
import Extensions
import OSLog
import Combine
import Models

public final class SideBarController: NSViewController {
    //MARK: - Private properties
    private let sideBarView: SideBarViewProtocol
    private let store: StoreOf<SideBarDomain>
    private var cancellable: Set<AnyCancellable> = .init()
    private var logger: Logger?
    
    private lazy var dataSource: NSCollectionViewDiffableDataSource<Int, String> = .init(
        collectionView: sideBarView.collection,
        itemProvider: makeItemProvider()
    )
    
    //MARK: - init(_:)
    public init(
        sideBarView: SideBarViewProtocol,
        store: StoreOf<SideBarDomain>,
        logger: Logger? = nil
    ) {
        self.sideBarView = sideBarView
        self.store = store
        self.logger = logger
        super.init(nibName: nil, bundle: nil)
        
        logger?.log(level: .debug, domain: self, event: #function)
    }
    
    //MARK: - deinit
    deinit {
        logger?.log(level: .debug, domain: self, event: #function)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
    public override func loadView() {
        self.view = sideBarView
        
        logger?.log(level: .debug, domain: self, event: #function)
    }
    
    public override func viewDidLoad() {
        configure(sideBarView.collection)
        sideBarView.collection.dataSource = dataSource
        
        store.$state
            .map(\.breeds)
            .removeDuplicates()
            .sink(receiveValue: updateDataSource)
            .store(in: &cancellable)
        
        logger?.log(level: .debug, domain: self, event: #function)
    }
    
    public override func viewWillAppear() {

        logger?.log(level: .debug, domain: self, event: #function)
    }
    
    public override func viewDidDisappear() {
        store.dispose()
        logger?.log(level: .debug, domain: self, event: #function)
    }
    
}

extension SideBarController: NSCollectionViewDelegate {
    public func collectionView(
        _ collectionView: NSCollectionView,
        didSelectItemsAt indexPaths: Set<IndexPath>
    ) {
        guard let index = indexPaths.first?.item else {
            return
        }
        store.send(.didSelectBreedAt(index))
    }
}

private extension SideBarController {
    func configure(_ collectionView: NSCollectionView) {
        collectionView.register(
            BreedItem.self,
            forItemWithIdentifier: BreedItem.identifier
        )
        collectionView.delegate = self
    }
    
    func updateDataSource(with breeds: [Breed]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])
        snapshot.appendItems(breeds.map(\.name), toSection: 0)
        dataSource.apply(snapshot)
    }
    
    func makeItemProvider() -> NSCollectionViewDiffableDataSource<Int, String>.ItemProvider {
        { collectionView, indexPath, title in
            guard let item = collectionView.makeItem(
                withIdentifier: BreedItem.identifier,
                for: indexPath
            ) as? BreedItem else {
                fatalError()
            }
            item.setText(title)
            return item
        }
    }
}

import SwiftUI
#Preview {
    SideBarController(
        sideBarView: SideBarView(),
        store: SideBarDomain.previewStore
    )
}
