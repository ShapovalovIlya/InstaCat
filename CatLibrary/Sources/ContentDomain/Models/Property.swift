//
//  Property.swift
//
//
//  Created by Илья Шаповалов on 18.09.2023.
//

import Foundation
import Models

struct Property: Hashable {
    let title: String
    let level: Int
    
    static let sample = Self(title: "Intelligence", level: 5)
}
