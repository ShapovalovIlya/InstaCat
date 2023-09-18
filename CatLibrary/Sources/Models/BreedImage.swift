//
//  BreedImage.swift
//
//
//  Created by Илья Шаповалов on 18.09.2023.
//

import Foundation

public struct BreedImage: Decodable, Equatable, Hashable {
    public let id: String
    public let url: String
    public let width: Int
    public let height: Int
    
    public init(
        id: String,
        url: String,
        width: Int,
        height: Int
    ) {
        self.id = id
        self.url = url
        self.width = width
        self.height = height
    }
    
    public static let sample = Self(
        id: "udZiLDG_E",
        url: "https://cdn2.thecatapi.com/images/udZiLDG_E.jpg",
        width: 880,
        height: 1100
    )
}
