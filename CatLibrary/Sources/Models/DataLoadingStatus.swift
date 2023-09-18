//
//  DataLoadingStatus.swift
//  
//
//  Created by Илья Шаповалов on 18.09.2023.
//

import Foundation

public enum DataLoadingStatus: Equatable {
    case none
    case loading
    case error(Error)
    
    public static func == (lhs: DataLoadingStatus, rhs: DataLoadingStatus) -> Bool {
        String(describing: lhs) == String(describing: rhs)
    }
}
