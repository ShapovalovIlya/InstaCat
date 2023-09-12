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
    private lazy var dataSource: NSCollectionViewDiffableDataSource<Int, String> = makeDataSource(for: sideBarView.collection)
    
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
 //       dataSource.supplementaryViewProvider
        
        Logger.viewCycle.log(level: .debug, domain: self, event: #function)
    }
    
}

private extension SideBarController {
    func makeDataSource(
        for collectionView: NSCollectionView
    ) -> NSCollectionViewDiffableDataSource<Int, String> {
        .init(
            collectionView: collectionView
        ) { collectionView, indexPath, identifier in
            return collectionView.makeItem(
                withIdentifier: .init(identifier),
                for: indexPath
            )
        }
    }
    
//    func makeHeaderProvider() -> NSCollectionViewDiffableDataSource.SupplementaryViewProvider {
//        { collectionView, kind, indexPath in
//            
//        }
//    }
}

import SwiftUI
#Preview {
    SideBarController(sideBarView: SideBarView())
}
