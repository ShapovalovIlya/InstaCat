//
//  ApiManager.swift
//
//
//  Created by Илья Шаповалов on 10.09.2023.
//

import Foundation
import Combine
import SwiftFP
import OSLog

public struct ApiManager {
    typealias Response = (data: Data, response: URLResponse)
    
    //MARK: - Private properties
    private let session: URLSession
    private let decoder: JSONDecoder
    private var logger: Logger?
    
    //MARK: - Public properties
    
    //MARK: - init(_:)
    public init(
        config: URLSessionConfiguration,
        logger: Logger? = nil
    ) {
        self.session = URLSession(configuration: config)
        self.decoder = JSONDecoder()
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
        self.logger = logger
    }
    
    //MARK: - Public methods
    public func getRequest<T: Decodable>(_ endpoint: Endpoint) -> AnyPublisher<T, Error> {
        logger?.log(level: .debug, domain: Self.self, event: #function)
        
        return compose(
            createRequest(method: .GET),
            mapToPublisher(session: session)
        )(endpoint.url)
            .tryMap(parseResponse)
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}

private extension ApiManager {
    //MARK: - HTTPMethod
    enum HTTPMethod: String {
        case GET
        case POST
    }
    
    //MARK: - Status codes
    enum StatusCodes: Int {
        case ok = 200
        case badRequest = 400
        case unauthorized = 401
        case forbidden = 403
        case notFound = 404
        case requestTimeout = 408
        case internalError = 500
        case badGateway = 502
        case gatewayTimeout = 504
        case unknown = 520
    }
    
    //MARK: - Private methods
    func createRequest(method: HTTPMethod) -> (URL) -> URLRequest {
        {
            var request = URLRequest(url: $0)
            request.httpMethod = method.rawValue
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            return request
        }
    }
    
    func mapToPublisher(session: URLSession) -> (URLRequest) -> AnyPublisher<Response, Error> {
        {
            URLSession
                .DataTaskPublisher(request: $0, session: session)
                .mapError { $0 }
                .eraseToAnyPublisher()
        }
    }
    
    func parseResponse(_ response: Response) throws -> Data {
        logger?.log(level: .debug, domain: Self.self, event: #function)
        logger?.log(level: .debug, domain: Self.self, event: String(describing: response.response))
        
        guard let httpResponse = response.response as? HTTPURLResponse else {
            throw URLError(.cannotParseResponse)
        }
        
        switch StatusCodes(rawValue: httpResponse.statusCode) {
        case .ok: return response.data
        case .badRequest: throw URLError(.resourceUnavailable)
        case .unauthorized: throw URLError(.userAuthenticationRequired)
        case .forbidden: throw URLError(.noPermissionsToReadFile)
        case .notFound: throw URLError(.fileDoesNotExist)
        case .requestTimeout, .gatewayTimeout: throw URLError(.timedOut)
        case .internalError, .unknown, .none: throw URLError(.unknown)
        case .badGateway: throw URLError(.dnsLookupFailed)
        }
    }
}
