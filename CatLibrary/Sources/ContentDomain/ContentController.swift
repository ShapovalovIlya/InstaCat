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

final class ContentController: NSViewController {
    //MARK: - Private properties
    private let store: StoreOf<ContentDomain>
    private let contentView: ContentViewProtocol
    private var cancellable: Set<AnyCancellable> = .init()
    private var logger: Logger?
    
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
    
}

import SwiftUI
#Preview {
    ContentController(
        store: ContentDomain.previewStore,
        contentView: ContentView()
    )
}
