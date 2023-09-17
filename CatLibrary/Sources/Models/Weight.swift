//
//  Weight.swift
//  
//
//  Created by Илья Шаповалов on 11.09.2023.
//

import Foundation

public struct Weight: Decodable, Equatable, Hashable {
    public let imperial: String
    public let metric: String
    
    public init(
        imperial: String,
        metric: String
    ) {
        self.imperial = imperial
        self.metric = metric
    }
    
    public static let sample = Self(
        imperial: "7  -  10",
        metric: "3 - 5"
    )
}
