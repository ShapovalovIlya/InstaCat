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

    override func setUp() async throws {
        try await super.setUp()
        
        sut = .init(getRequest: { _ in
            Empty().eraseToAnyPublisher()
        })
        state = .init()
        spy = .init()
    }
    
    override func tearDown() async throws {
        sut = nil
        state = nil
        spy = nil
        
        try await super.tearDown()
    }
    
    func test_windowDidLoadEmitFetchBreedsRequest() {
        spy.schedule(
            sut.reduce(&state, action: .windowDidLoad)
        )
        
        XCTAssertEqual(spy.actions.first, ._fetchBreedsRequest)
    }
    
    func test_fetchBreedsRequestEndWithSuccess() {
        sut = .init(getRequest: { _ in
            Just([testBreedModel])
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        })
        
        spy.schedule(
            sut.reduce(&state, action: ._fetchBreedsRequest)
        )
        
        XCTAssertEqual(spy.actions.count, 1)
        XCTAssertEqual(spy.actions.first, ._fetchBreedsResponse(.success([testBreedModel])))
    }
    
    func test_fetchBreedsRequestEndWithError() {
        sut = .init(getRequest: { _ in
            Fail(error: testError)
                .eraseToAnyPublisher()
        })
        
        spy.schedule(
            sut.reduce(&state, action: ._fetchBreedsRequest)
        )
        
        XCTAssertEqual(spy.actions.count, 1)
        XCTAssertEqual(spy.actions.first, ._fetchBreedsResponse(.failure(testError)))
    }
    
    func test_reduceSuccessFetchBreedResponse() {
        _ = sut.reduce(&state, action: ._fetchBreedsResponse(.success([testBreedModel])))
        
        XCTAssertEqual(state.breeds, [testBreedModel])
    }
    
    func test_reduceSetSelectedBreed() {
        _ = sut.reduce(&state, action: .setSelectedBreed(testBreedModel))
        
        XCTAssertEqual(state.selectedBreed, testBreedModel)
    }
}
