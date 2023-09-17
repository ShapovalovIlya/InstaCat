//
//  Repository.swift
//
//
//  Created by Илья Шаповалов on 15.09.2023.
//

import Foundation
import Combine

public struct Repository {
    //MARK: - Private properties
    private let apiManager: ApiManager
    private let cache: Cache<URL, Decodable>
    
    //MARK: - init(_:)
    public init(
        session: URLSession = .shared,
        entryLifeTime: TimeInterval,
        maximumEntryCount: Int
    ) {
        apiManager = .init(session: session)
        cache = .init(
            entryLifeTime: entryLifeTime,
            maximumEntryCount: maximumEntryCount
        )
    }
    
//    public func getRequest<T: Decodable>(_ endpoint: Endpoint) -> AnyPublisher<T, Error> {
//            
//    }
    
    
}
