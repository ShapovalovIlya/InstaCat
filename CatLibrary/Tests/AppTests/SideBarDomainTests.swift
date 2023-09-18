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
    
    override func setUp() async throws {
        try await super.setUp()
        
        sut = .init()
        state = .init()
    }
    
    override func tearDown() async throws {
        sut = nil
        state = nil
    }
    
    func test_reduceSetBreeds() {
        _ = sut.reduce(&state, action: .setBreeds([testBreedModel]))
        
        XCTAssertEqual(state.breeds, [testBreedModel])
    }
    
    func test_reduceSetSelectedBreed() {
        state.breeds = [testBreedModel]
        
        _ = sut.reduce(&state, action: .didSelectBreedAt(0))
        
        XCTAssertEqual(state.selectedBreed, testBreedModel)
    }
    
}
