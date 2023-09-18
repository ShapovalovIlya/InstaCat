//
//  Description.swift
//
//
//  Created by Илья Шаповалов on 18.09.2023.
//

import Foundation
import Models

struct Description: Hashable {
    let name: String
    let description: String
    let temperament: String
    
    init(breed: Breed) {
        name = breed.name
        description = breed.description
        temperament = breed.temperament
    }
    
    static let sample = Self(breed: .sample)
}
