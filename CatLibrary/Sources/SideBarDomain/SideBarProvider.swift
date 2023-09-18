//
//  SideBarProvider.swift
//
//
//  Created by Илья Шаповалов on 14.09.2023.
//

import Foundation
import SwiftUDF
import OSLog
import Dependencies

public struct SideBarProvider {
    //MARK: - Public properties
    public let viewController: SideBarController
    public let store: StoreOf<SideBarDomain>
    
    //MARK: - Private properties
    private let view: SideBarViewProtocol
    private let repository: Repository
    
    public init() {
        repository = .init(logger: Logger.system)
        store = Store(
            state: SideBarDomain.State(),
            reducer: SideBarDomain(getRequest: repository.getRequest)
        )
        view = SideBarView()
        viewController = SideBarController(
            sideBarView: view,
            store: store,
            logger: Logger.viewCycle
        )
    }
}
