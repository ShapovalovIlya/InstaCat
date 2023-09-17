//
//  Repository.swift
//
//
//  Created by Илья Шаповалов on 15.09.2023.
//

import Foundation
import Combine
import OSLog
import Extensions

public struct Repository {
    //MARK: - Private properties
    private let apiManager: ApiManager
    private let cache: Cache<URL, Decodable>
    private var logger: Logger?
    
    //MARK: - init(_:)
    public init(
        timeoutInterval: TimeInterval = .minute,
        cacheLifeTime: TimeInterval = .day,
        maximumEntryCount: Int = 10,
        logger: Logger? = nil
    ) {
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        config.timeoutIntervalForResource = timeoutInterval
        
        apiManager = .init(config: config)
        cache = .init(
            entryLifeTime: cacheLifeTime,
            maximumEntryCount: maximumEntryCount
        )
    }
    
    //MARK: - Public methods
    public func getRequest<T: Decodable>(_ endpoint: Endpoint) -> AnyPublisher<T, Error> {
        logger?.log(level: .debug, domain: self, event: #function)
        return apiManager.getRequest(endpoint)
//        return cache.value(forKey: endpoint.url)
//            .publisher
//            .tryMap(tryCast)
//            .catch { _ in sendApiRequest(to: endpoint) }
//            .eraseToAnyPublisher()
    }
    
}

private extension Repository {
    //MARK: - Private methods
    private func tryCast<T: Decodable>(_ value: Decodable) throws -> T {
        guard let content = value as? T else {
            throw MachError(.failure)
        }
        return content
    }
    
    private func cache<T: Decodable>(value: T, forKey key: URL) -> T {
        logger?.log(level: .debug, domain: self, event: #function)
        cache.insert(value, forKey: key)
        return value
    }
    
    private func sendApiRequest<T: Decodable>(to endpoint: Endpoint) -> AnyPublisher<T, Error> {
        logger?.log(level: .debug, domain: self, event: #function)
        return apiManager
            .getRequest(endpoint)
            .map { cache(value: $0, forKey: endpoint.url) }
            .eraseToAnyPublisher()
    }
}
