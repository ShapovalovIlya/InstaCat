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

final class ContentDomainTests: XCTestCase {
    private var sut: ContentDomain!
    private var state: ContentDomain.State!
    private var testModel: Breed!
    
    override func setUp() async throws {
        try await super.setUp()
        
        sut = .init()
        state = .init()
        testModel = breedModel
    }
    
    override func tearDown() async throws {
        sut = nil
        state = nil
        testModel = nil
        
        try await super.tearDown()
    }
    
    func test_recudeSetBreed() {
        _ = sut.reduce(&state, action: .setBreed(testModel))
        
        XCTAssertEqual(state.breed, testModel)
    }
}
