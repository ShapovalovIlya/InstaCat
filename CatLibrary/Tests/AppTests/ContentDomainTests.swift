//
//  ContentDomainTests.swift
//  
//
//  Created by Илья Шаповалов on 18.09.2023.
//

import XCTest
import ContentDomain
import Models
import SwiftUDF
import Combine

final class ContentDomainTests: XCTestCase {
    private var sut: ContentDomain!
    private var state: ContentDomain.State!
    private var spy: ReducerSpy<ContentDomain.Action>!
    
    override func setUp() async throws {
        try await super.setUp()
        
        sut = .init { _ in
            Empty().eraseToAnyPublisher()
        }
        state = .init()
        spy = .init()
    }
    
    override func tearDown() async throws {
        sut = nil
        state = nil
        spy = nil
        
        try await super.tearDown()
    }
    
    func test_recudeSetBreed() {
        _ = sut.reduce(&state, action: .setBreed(testBreedModel))
        
        XCTAssertEqual(state.breed, testBreedModel)
    }
    
    func test_setBreedEmitImageRequestAction() {
        spy.schedule(
            sut.reduce(&state, action: .setBreed(testBreedModel))
        )
        
        XCTAssertEqual(spy.actions.count, 1)
        XCTAssertEqual(spy.actions.first, ._fetchImageRequest(testBreedModel.id))
    }
    
    func test_fetchImageRequestEndWithSuccess() {
        sut = .init(getImageRequest: { _ in
            Just(testBreedImageModel)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        })
        
        spy.schedule(
            sut.reduce(&state, action: ._fetchImageRequest("Baz"))
        )
        
        XCTAssertEqual(spy.actions.count, 1)
        XCTAssertEqual(spy.actions.first, ._fetchImageResponse(.success(testBreedImageModel)))
        XCTAssertEqual(state.dataLoadingStatus, .loading)
    }
    
    func test_fetchImageRequestEndWithError() {
        sut = .init(getImageRequest: { _ in
            Fail(error: testError)
                .eraseToAnyPublisher()
        })
        
        spy.schedule(
            sut.reduce(&state, action: ._fetchImageRequest("Baz"))
        )
        
        XCTAssertEqual(spy.actions.count, 1)
        XCTAssertEqual(spy.actions.first, ._fetchImageResponse(.failure(testError)))
        XCTAssertEqual(state.dataLoadingStatus, .loading)
    }
    
    func test_reduceSuccessImageResponse() {
        _ = sut.reduce(&state, action: ._fetchImageResponse(.success(testBreedImageModel)))
        
        XCTAssertEqual(state.breedImage, testBreedImageModel)
        XCTAssertEqual(state.dataLoadingStatus, .none)
    }
    
    func test_reduceFailedImageResponse() {
        _ = sut.reduce(&state, action: ._fetchImageResponse(.failure(testError)))
        
        XCTAssertNil(state.breedImage)
        XCTAssertEqual(state.dataLoadingStatus, .error(testError))
    }
}
