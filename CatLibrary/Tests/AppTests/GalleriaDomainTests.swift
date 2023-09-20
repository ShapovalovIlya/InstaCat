//
//  GalleriaDomainTests.swift
//  
//
//  Created by Илья Шаповалов on 20.09.2023.
//

import XCTest
import SwiftUDF
import GalleriaDomain
import Combine

final class GalleriaDomainTests: XCTestCase {
    private var sut: GalleriaDomain!
    private var state: GalleriaDomain.State!
    private var spy: ReducerSpy<GalleriaDomain.Action>!
    
    override func setUp() async throws {
        try await super.setUp()
        
        sut = .init { _ in Empty().eraseToAnyPublisher() }
        state = .init(breedId: "Baz")
        spy = .init()
    }
    
    override func tearDown() async throws {
        spy = nil
        state = nil
        sut = nil
        
        try await super.tearDown()
    }
    
    func test_viewWillAppearEmitImageRequest() {
        spy.schedule(
            sut.reduce(&state, action: .viewWillAppear)
        )
        
        XCTAssertEqual(spy.actions.count, 1)
        XCTAssertEqual(spy.actions.first, ._fetchImageRequest)
    }
    
    func test_fetchImageRequestEndWithSuccess() {
        sut = .init { _ in
            Just([testBreedImageModel])
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        spy.schedule(
            sut.reduce(&state, action: ._fetchImageRequest)
        )
        
        XCTAssertEqual(spy.actions.count, 1)
        XCTAssertEqual(state.dataLoadingStatus, .loading)
        XCTAssertEqual(spy.actions.first, ._fetchImageResponse(.success([testBreedImageModel])))
    }
    
    func test_fetchImageRequestEndWithError() {
        sut = .init { _ in
            Fail(error: testError)
                .eraseToAnyPublisher()
        }
        
        spy.schedule(
            sut.reduce(&state, action: ._fetchImageRequest)
        )
        
        XCTAssertEqual(spy.actions.count, 1)
        XCTAssertEqual(state.dataLoadingStatus, .loading)
        XCTAssertEqual(spy.actions.first, ._fetchImageResponse(.failure(testError)))
    }
    
    func test_reduceSuccessImageResponse() {
        _ = sut.reduce(&state, action: ._fetchImageResponse(.success([testBreedImageModel])))
        
        XCTAssertTrue(state.images.contains(testBreedImageModel))
        
        _ = sut.reduce(&state, action: ._fetchImageResponse(.success([testBreedImageModel])))
        
        XCTAssertEqual(
            state.images,
            Array(repeating: testBreedImageModel, count: 2)
        )
        
        _ = sut.reduce(&state, action: ._fetchImageResponse(.success([testBreedImageModel])))
        
        XCTAssertEqual(
            state.images,
            Array(repeating: testBreedImageModel, count: 3)
        )
    }
    
    func test_willDisplayImageAtEmitFetchImageRequest() {
        state.images = Array(repeating: testBreedImageModel, count: 5)
        
        spy.schedule(
            sut.reduce(&state, action: .willDisplayImageAt(1))
        )
        
        XCTAssertEqual(spy.actions.count, 1)
        XCTAssertEqual(spy.actions.first, ._fetchImageRequest)
    }
    
    func test_willDisplayImageAtEmitNothing() {
        state.images = Array(repeating: testBreedImageModel, count: 6)
        
        spy.schedule(
            sut.reduce(&state, action: .willDisplayImageAt(1))
        )
        
        XCTAssertTrue(spy.actions.isEmpty)
    }

}
