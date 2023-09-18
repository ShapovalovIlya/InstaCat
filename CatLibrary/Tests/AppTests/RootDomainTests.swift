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
        
        sut = .init()
        state = .init()
        spy = .init()
    }
    
    override func tearDown() async throws {
        sut = nil
        state = nil
        spy = nil
        
        try await super.tearDown()
    }
    
}
