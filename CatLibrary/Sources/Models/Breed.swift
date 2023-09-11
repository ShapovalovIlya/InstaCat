//
//  Breed.swift
//
//
//  Created by Илья Шаповалов on 10.09.2023.
//

import Foundation

public struct Breed: Decodable, Identifiable {
    public let weight: Weight
    public let id: String
    public let name: String
    public let cfaURL: String
    public let vetstreetURL: String
    public let vcahospitalsURL: String
    public let temperament: String
    public let origin: String
    public let countryCodes: String
    public let countryCode: String
    public let description: String
    public let lifeSpan: String
    public let indoor: Bool
    public let lap: Int
    public let altNames: String
    public let adaptability: Int
    public let affectionLevel: Int
    public let childFriendly: Int
    public let dogFriendly: Int
    public let energyLevel: Int
    public let grooming: Int
    public let healthIssues: Int
    public let intelligence: Int
    public let sheddingLevel: Int
    public let socialNeeds: Int
    public let strangerFriendly: Int
    public let vocalisation: Int
    public let experimental: Bool
    public let hairless: Bool
    public let natural: Bool
    public let rare: Bool
    public let rex: Bool
    public let suppressedTail: Bool
    public let shortLegs: Bool
    public let wikipediaURL: String
    public let hypoallergenic: Bool
    public let referenceImageID: String
}
