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

public final class SideBarController: NSViewController {
    //MARK: - Private properties
    private let sideBarView: SideBarViewProtocol
    private lazy var dataSource: NSCollectionViewDiffableDataSource<Int, String> = .init(
        collectionView: sideBarView.collection,
        itemProvider: makeItemProvider()
    )
    
    //MARK: - init(_:)
    public init(
        sideBarView: SideBarViewProtocol
    ) {
        self.sideBarView = sideBarView
        super.init(nibName: nil, bundle: nil)
        
        Logger.viewCycle.log(level: .debug, domain: self, event: #function)
    }
    
    //MARK: - deinit
    deinit {
        Logger.viewCycle.log(level: .debug, domain: self, event: #function)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
    public override func loadView() {
        self.view = sideBarView
        
        Logger.viewCycle.log(level: .debug, domain: self, event: #function)
    }
    
    public override func viewDidLoad() {
        configure(sideBarView.collection)
        sideBarView.collection.dataSource = dataSource
        
        Logger.viewCycle.log(level: .debug, domain: self, event: #function)
    }
    
    public override func viewWillAppear() {
        updateDataSource(with: ["one", "two", "three"])
        Logger.viewCycle.log(level: .debug, domain: self, event: #function)
    }
    
}

extension SideBarController: NSCollectionViewDelegate {
    public func collectionView(
        _ collectionView: NSCollectionView,
        didSelectItemsAt indexPaths: Set<IndexPath>
    ) {
        print("select item at: \(indexPaths)")
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
    
    func updateDataSource(with titles: [String]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])
        snapshot.appendItems(titles, toSection: 0)
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
    SideBarController(sideBarView: SideBarView())
}
