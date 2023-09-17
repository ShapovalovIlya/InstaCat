//
//  Breed.swift
//
//
//  Created by Илья Шаповалов on 10.09.2023.
//

import Foundation

public struct Breed: Decodable, Identifiable, Equatable, Hashable {
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
    public let lap: Bool?
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
    
    public init(
        weight: Weight,
        id: String,
        name: String,
        cfaURL: String,
        vetstreetURL: String,
        vcahospitalsURL: String,
        temperament: String,
        origin: String,
        countryCodes: String,
        countryCode: String,
        description: String,
        lifeSpan: String,
        indoor: Bool,
        lap: Bool?,
        altNames: String,
        adaptability: Int,
        affectionLevel: Int,
        childFriendly: Int,
        dogFriendly: Int,
        energyLevel: Int,
        grooming: Int,
        healthIssues: Int,
        intelligence: Int,
        sheddingLevel: Int,
        socialNeeds: Int,
        strangerFriendly: Int,
        vocalisation: Int,
        experimental: Bool,
        hairless: Bool,
        natural: Bool,
        rare: Bool,
        rex: Bool,
        suppressedTail: Bool,
        shortLegs: Bool,
        wikipediaURL: String,
        hypoallergenic: Bool,
        referenceImageID: String
    ) {
        self.weight = weight
        self.id = id
        self.name = name
        self.cfaURL = cfaURL
        self.vetstreetURL = vetstreetURL
        self.vcahospitalsURL = vcahospitalsURL
        self.temperament = temperament
        self.origin = origin
        self.countryCodes = countryCodes
        self.countryCode = countryCode
        self.description = description
        self.lifeSpan = lifeSpan
        self.indoor = indoor
        self.lap = lap
        self.altNames = altNames
        self.adaptability = adaptability
        self.affectionLevel = affectionLevel
        self.childFriendly = childFriendly
        self.dogFriendly = dogFriendly
        self.energyLevel = energyLevel
        self.grooming = grooming
        self.healthIssues = healthIssues
        self.intelligence = intelligence
        self.sheddingLevel = sheddingLevel
        self.socialNeeds = socialNeeds
        self.strangerFriendly = strangerFriendly
        self.vocalisation = vocalisation
        self.experimental = experimental
        self.hairless = hairless
        self.natural = natural
        self.rare = rare
        self.rex = rex
        self.suppressedTail = suppressedTail
        self.shortLegs = shortLegs
        self.wikipediaURL = wikipediaURL
        self.hypoallergenic = hypoallergenic
        self.referenceImageID = referenceImageID
    }
    
    public static let sample = Self(
        weight: .sample,
        id: "abys",
        name: "Abyssinian",
        cfaURL: "http://cfa.org/Breeds/BreedsAB/Abyssinian.aspx",
        vetstreetURL: "http://www.vetstreet.com/cats/abyssinian",
        vcahospitalsURL: "https://vcahospitals.com/know-your-pet/cat-breeds/abyssinian",
        temperament: "Active, Energetic, Independent, Intelligent, Gentle",
        origin: "Egypt",
        countryCodes: "EG",
        countryCode: "EG",
        description: "The Abyssinian is easy to care for, and a joy to have in your home. They’re affectionate cats and love both people and other animals.",
        lifeSpan: "14 - 15",
        indoor: false,
        lap: true,
        altNames: "",
        adaptability: 5,
        affectionLevel: 5,
        childFriendly: 3,
        dogFriendly: 4,
        energyLevel: 5,
        grooming: 1,
        healthIssues: 2,
        intelligence: 5,
        sheddingLevel: 2,
        socialNeeds: 5,
        strangerFriendly: 5,
        vocalisation: 1,
        experimental: false,
        hairless: false,
        natural: true,
        rare: false,
        rex: false,
        suppressedTail: false,
        shortLegs: false,
        wikipediaURL: "https://en.wikipedia.org/wiki/Abyssinian_(cat)",
        hypoallergenic: false,
        referenceImageID: "0XYvRd7oD"
    )
}
