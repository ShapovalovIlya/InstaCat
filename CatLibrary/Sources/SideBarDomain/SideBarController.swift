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
    private let itemIdentifier = NSUserInterfaceItemIdentifier("ItemIdentifier")
//    private let headerIdentifier = NSUserInterfaceItemIdentifier("HeaderIdentifier")
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
        
        sideBarView.collection.register(
            NSCollectionViewItem.self,
            forItemWithIdentifier: itemIdentifier
        )
        sideBarView.collection.dataSource = dataSource
//        sideBarView.collection.register(
//            <#T##viewClass: AnyClass?##AnyClass?#>,
//            forSupplementaryViewOfKind: NSCollectionView.elementKindSectionHeader,
//            withIdentifier: <#T##NSUserInterfaceItemIdentifier#>
//        )
 //       dataSource.supplementaryViewProvider = makeHeaderProvider()
        
        Logger.viewCycle.log(level: .debug, domain: self, event: #function)
    }
    
    public override func viewWillAppear() {
        updateDataSource(with: ["one", "two", "three"])
        Logger.viewCycle.log(level: .debug, domain: self, event: #function)
    }
    
}

private extension SideBarController {
    func updateDataSource(with titles: [String]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])
        snapshot.appendItems(titles, toSection: 0)
        dataSource.apply(snapshot)
    }
    
    func makeItemProvider() -> NSCollectionViewDiffableDataSource<Int, String>.ItemProvider {
        { [unowned self] collectionView, indexPath, title in
            let item = collectionView.makeItem(
                withIdentifier: itemIdentifier,
                for: indexPath
            )
            item.textField?.backgroundColor = NSColor.white
            item.title = title
            return item
        }
    }
}

import SwiftUI
#Preview {
    SideBarController(sideBarView: SideBarView())
}
