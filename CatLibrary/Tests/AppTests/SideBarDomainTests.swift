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

final class SideBarDomainTests: XCTestCase {
    private var sut: SideBarDomain!
    private var state: SideBarDomain.State!
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
    }
    
    func test_reduceSetBreeds() {
        _ = sut.reduce(&state, action: .setBreeds([testModel]))
        
        XCTAssertEqual(state.breeds, [testModel])
    }
    
    func test_reduceSetSelectedBreed() {
        state.breeds = [testModel]
        
        _ = sut.reduce(&state, action: .didSelectBreedAt(0))
        
        XCTAssertEqual(state.selectedBreed, testModel)
    }
    
}
