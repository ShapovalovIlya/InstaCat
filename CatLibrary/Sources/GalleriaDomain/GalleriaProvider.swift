//
//  GalleriaProvider.swift
//
//
//  Created by Илья Шаповалов on 20.09.2023.
//

import Foundation
import SwiftUDF
import Dependencies
import Extensions
import OSLog

public struct GalleriaProvider {
    //MARK: - Public properties
    public let windowController: GalleriaWindowController
    
    //MARK: - Private properties
    private let viewController: GalleriaViewController
    private let view: GalleriaViewProtocol
    private let store: StoreOf<GalleriaDomain>
    private let repository: Repository
    
    //MARK: - init(_:)
    public init(breedId: String) {
        repository = .init(logger: Logger.system)
        store = .init(
            state: GalleriaDomain.State(breedId: breedId),
            reducer: GalleriaDomain(getImageRequest: repository.getRequest)
        )
        view = GalleriaView()
        viewController = .init(
            galleriaView: view,
            store: store,
            logger: Logger.viewCycle
        )
        windowController = .init(
            viewController: viewController,
            logger: Logger.windowCycle
        )
    }
}
