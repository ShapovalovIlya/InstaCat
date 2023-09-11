//
//  Endpoint.swift
//
//
//  Created by Илья Шаповалов on 09.09.2023.
//

import Foundation

public struct Endpoint {
    private let path: String
    private let queryItems: [URLQueryItem]
    
    public var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.thecatapi.com/v1/"
        components.path = path
        
        if !queryItems.isEmpty {
            components.queryItems = queryItems
        }
        guard let url = components.url else {
            preconditionFailure("Unable to create url from: \(components)")
        }
        return url
    }
    
    //MARK: - init(_:)
    public init(
        path: String,
        queryItems: [URLQueryItem] = .init()
    ) {
        self.path = path
        self.queryItems = queryItems
    }
    
    //MARK: - Methods
    static let breeds = Self(path: "breeds")
    static func photos(
        breedIDs: String...,
        limit: Int = 10,
        page: Int = 0
    ) -> Self {
        .init(
            path: "images/search",
            queryItems: [
                .init(name: "breed_ids", value: breedIDs.joined(separator: ",")),
                .init(name: "limit", value: limit.description),
                .init(name: "page", value: page.description)
            ]
        )
    }
}
