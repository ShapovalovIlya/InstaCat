//
//  RootDomainTests.swift
//  
//
//  Created by Илья Шаповалов on 14.09.2023.
//

import XCTest
import SwiftUDF
import RootDomain
import Models
import Combine

final class RootDomainTests: XCTestCase {
    private var sut: RootDomain!
    private var state: RootDomain.State!
    private var spy: ReducerSpy<RootDomain.Action>!
    private var testModel: Breed!
    private var testError: URLError!

    override func setUp() async throws {
        try await super.setUp()
        
        sut = .init(getRequest: { _ in
            Empty(
                outputType: [Breed].self,
                failureType: Error.self
            )
            .eraseToAnyPublisher()
        })
        state = .init()
        spy = .init()
        testModel = breedModel
        testError = .init(.badURL)
    }
    
    override func tearDown() async throws {
        sut = nil
        state = nil
        spy = nil
        testModel = nil
        testError = nil
        
        try await super.tearDown()
    }
    
    func test_windowDidLoadEmitFetchBreedsRequest() {
        spy.schedule(
            sut.reduce(&state, action: .windowDidLoad)
        )
        
        XCTAssertEqual(spy.actions.first, ._fetchBreedsRequest)
    }
    
    func test_fetchBreedsRequestEndWithSuccess() {
        sut = .init(getRequest: { [unowned self] _ in
            Just([testModel])
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        })
        
        spy.schedule(
            sut.reduce(&state, action: ._fetchBreedsRequest)
        )
        
        XCTAssertEqual(spy.actions.first, ._fetchBreedsResponse(.success([testModel])))
    }
    
    func test_fetchBreedsRequestEndWithError() {
        sut = .init(getRequest: { [unowned self] _ in
            Fail(error: testError)
                .eraseToAnyPublisher()
        })
        
        spy.schedule(
            sut.reduce(&state, action: ._fetchBreedsRequest)
        )
        
        XCTAssertEqual(spy.actions.first, ._fetchBreedsResponse(.failure(testError)))
    }
    
    func test_reduceSuccessFetchBreedResponse() {
        _ = sut.reduce(&state, action: ._fetchBreedsResponse(.success([testModel])))
        
        XCTAssertEqual(state.breeds, [testModel])
    }
    
    func test_reduceSetSelectedBreed() {
        _ = sut.reduce(&state, action: .setSelectedBreed(testModel))
        
        XCTAssertEqual(state.selectedBreed, testModel)
    }
}
