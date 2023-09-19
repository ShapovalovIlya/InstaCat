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
    public let cfaURL: String?
    public let vetstreetUrl: String?
    public let vcahospitalsUrl: String?
    public let temperament: String
    public let origin: String
    public let countryCodes: String
    public let countryCode: String
    public let description: String
    public let lifeSpan: String
    public let indoor: Int
    public let lap: Int?
    public let altNames: String?
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
    public let experimental: Int
    public let hairless: Int
    public let natural: Int
    public let rare: Int
    public let rex: Int
    public let suppressedTail: Int
    public let shortLegs: Int
    public let wikipediaUrl: String?
    public let hypoallergenic: Int
    public let referenceImageID: String?
    
    public init(
        weight: Weight,
        id: String,
        name: String,
        cfaURL: String? = nil,
        vetstreetURL: String,
        vcahospitalsURL: String,
        temperament: String,
        origin: String,
        countryCodes: String,
        countryCode: String,
        description: String,
        lifeSpan: String,
        indoor: Int,
        lap: Int? = nil,
        altNames: String? = nil,
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
        experimental: Int,
        hairless: Int,
        natural: Int,
        rare: Int,
        rex: Int,
        suppressedTail: Int,
        shortLegs: Int,
        wikipediaURL: String? = nil,
        hypoallergenic: Int,
        referenceImageID: String? = nil
    ) {
        self.weight = weight
        self.id = id
        self.name = name
        self.cfaURL = cfaURL
        self.vetstreetUrl = vetstreetURL
        self.vcahospitalsUrl = vcahospitalsURL
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
        self.wikipediaUrl = wikipediaURL
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
        indoor: 1,
        lap: 1,
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
        experimental: 1,
        hairless: 1,
        natural: 1,
        rare: 1,
        rex: 1,
        suppressedTail: 1,
        shortLegs: 1,
        wikipediaURL: "https://en.wikipedia.org/wiki/Abyssinian_(cat)",
        hypoallergenic: 1,
        referenceImageID: "0XYvRd7oD"
    )
}
