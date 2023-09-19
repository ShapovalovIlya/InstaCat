//
//  BreedDetail.swift
//
//
//  Created by Илья Шаповалов on 19.09.2023.
//

import Foundation
import Models

struct BreedDetail: Hashable, Equatable {
    let titleImage: BreedImage
    let description: Description
    let properties: [Property]
    let links: [Link]
}
