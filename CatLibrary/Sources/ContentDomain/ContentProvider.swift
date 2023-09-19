//
//  ContentProvider.swift
//
//
//  Created by Илья Шаповалов on 20.09.2023.
//

import Foundation
import SwiftUDF
import OSLog
import Dependencies

public struct ContentProvider {
    //MARK: - Public properties
    public let viewController: ContentController
    public let store: StoreOf<ContentDomain>
    
    //MARK: - Private properties
    private let view: ContentViewProtocol
    private let repository: Repository
    
    //MARK: - init(_:)
    public init() {
        repository = .init(logger: Logger.system)
        store = .init(
            state: ContentDomain.State(),
            reducer: ContentDomain(getImageRequest: repository.getRequest)
        )
        view = ContentView()
        viewController = ContentController(
            store: store,
            contentView: view,
            logger: Logger.viewCycle
        )
    }
    
}
