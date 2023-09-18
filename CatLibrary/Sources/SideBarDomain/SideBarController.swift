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
    
    private lazy var dataSource: SideBarDataSource = .init(collectionView: sideBarView.collection)
    
    //MARK: - init(_:)
    init(
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
        cancellable.removeAll()
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
        super.viewDidLoad()
        configure(sideBarView.collection)
        
        store.$state
            .map(\.breeds)
            .removeDuplicates()
            .sink(receiveValue: dataSource.reload(with:))
            .store(in: &cancellable)
        
        logger?.log(level: .debug, domain: self, event: #function)
    }
    
    public override func viewWillAppear() {
        super.viewWillAppear()
        store.send(.viewWillAppear)
    }
    
    public override func viewDidDisappear() {
        super.viewDidDisappear()
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
        collectionView.dataSource = dataSource
    }
}

//import SwiftUI
//#Preview {
//    SideBarController(
//        sideBarView: SideBarView(),
//        store: SideBarDomain.previewStore
//    )
//}
