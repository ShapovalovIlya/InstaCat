//
//  Item.swift
//
//
//  Created by Илья Шаповалов on 19.09.2023.
//

import Foundation
import Models

enum Item: Hashable {
    case title(BreedImage)
    case description(Description)
    case property(Property)
    case link(Link)
}
