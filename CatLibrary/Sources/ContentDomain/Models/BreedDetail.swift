//
//  BreedDetail.swift
//
//
//  Created by Илья Шаповалов on 19.09.2023.
//

import Foundation
import Models

public struct BreedDetail: Hashable, Equatable {
    let titleImage: BreedImage?
    let description: Description
    let details: [String]
    let properties: [Property]
    let links: [Link]
    
    public init(
        breedImage: BreedImage,
        breed: Breed
    ) {
        self.titleImage = breedImage
        self.description = .init(breed: breed)
        // Detail
        var details = [String]()
        if breed.indoor > 0 {
            details.append("Indoor")
        }
        if breed.experimental > 0 {
            details.append("Experimental")
        }
        if breed.suppressedTail > 0 {
            details.append("Suppressed tail")
        }
        if breed.hairless > 0 {
            details.append("Hairless")
        }
        if breed.natural > 0 {
            details.append("Natural")
        }
        if breed.rare > 0 {
            details.append("Rare")
        }
        if breed.rex > 0 {
            details.append("Rex")
        }
        if breed.shortLegs > 0 {
            details.append("Short legs")
        }
        if breed.hypoallergenic > 0 {
            details.append("Hypoallergenic")
        }
        self.details = details
        
        // Properties
        var properties = [Property]()
        properties.append(Property(title: "Adaptability", level: breed.adaptability))
        properties.append(Property(title: "Affection level", level: breed.affectionLevel))
        properties.append(Property(title: "Child friendly", level: breed.childFriendly))
        properties.append(Property(title: "Dog friendly", level: breed.dogFriendly))
        properties.append(Property(title: "Energy level", level: breed.energyLevel))
        properties.append(Property(title: "Grooming", level: breed.grooming))
        properties.append(Property(title: "Health issues", level: breed.healthIssues))
        properties.append(Property(title: "Intelligence", level: breed.intelligence))
        properties.append(Property(title: "Shedding level", level: breed.sheddingLevel))
        properties.append(Property(title: "Social needs", level: breed.socialNeeds))
        properties.append(Property(title: "Stranger friendly", level: breed.strangerFriendly))
        properties.append(Property(title: "Vocalisation", level: breed.vocalisation))
        self.properties = properties
        
        // Links
        var links = [Link]()
        if let cfa = breed.cfaURL {
            links.append(Link(title: "CFA", link: cfa))
        }
        if let vetstreet = breed.vetstreetUrl {
            links.append(Link(title: "Vetstreet", link: vetstreet))
        }
        if let vcahospitals = breed.vetstreetUrl {
            links.append(Link(title: "VCA hospitals", link: vcahospitals))
        }
        if let wikipedia = breed.wikipediaUrl {
            links.append(Link(title: "Wikipedia", link: wikipedia))
        }
        self.links = links
    }
    
    static let sample = Self(breedImage: .sample, breed: .sample)
}
