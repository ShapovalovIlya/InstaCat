//
//  SideBarProvider.swift
//
//
//  Created by Илья Шаповалов on 14.09.2023.
//

import Foundation
import SwiftUDF

public struct SideBarProvider {
    //MARK: - Public properties
    public let viewController: SideBarController
    public let store: StoreOf<SideBarDomain>
    
    //MARK: - Private properties
    private let view: SideBarViewProtocol
    
    public init() {
        view = SideBarView()
        store = Store(
            state: SideBarDomain.State(),
            reducer: SideBarDomain()
        )
        viewController = SideBarController(sideBarView: view)
    }
}
