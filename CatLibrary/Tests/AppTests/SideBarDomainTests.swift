//
//  SideBarDomainTests.swift
//  
//
//  Created by Илья Шаповалов on 18.09.2023.
//

import XCTest
import SideBarDomain
import SwiftUDF
import Models
import Combine

final class SideBarDomainTests: XCTestCase {
    private var sut: SideBarDomain!
    private var state: SideBarDomain.State!
    private var spy: ReducerSpy<SideBarDomain.Action>!
    
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
    }
    
    func test_reduceSetSelectedBreed() {
        state.breeds = [testBreedModel]
        
        _ = sut.reduce(&state, action: .didSelectBreedAt(0))
        
        XCTAssertEqual(state.selectedBreed, testBreedModel)
    }
    
    func test_viewWillAppearEmitFetchBreedsRequest() {
        spy.schedule(
            sut.reduce(&state, action: .viewWillAppear)
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
        XCTAssertEqual(state.dataLoadingStatus, .loading)
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
        XCTAssertEqual(state.dataLoadingStatus, .loading)
    }
    
    func test_reduceSuccessFetchBreedResponse() {
        _ = sut.reduce(&state, action: ._fetchBreedsResponse(.success([testBreedModel])))
        
        XCTAssertEqual(state.breeds, [testBreedModel])
        XCTAssertEqual(state.dataLoadingStatus, .none)
    }
    
    func test_reduceFailedFetchBreedResponse() {
        _ = sut.reduce(&state, action: ._fetchBreedsResponse(.failure(testError)))
        
        XCTAssertEqual(state.dataLoadingStatus, .error(testError))
    }
    
}
