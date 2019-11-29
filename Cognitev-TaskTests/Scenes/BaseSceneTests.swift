//
//  BaseSceneTests.swift
//  Cognitev-TaskTests
//
//  Created by Ahmed Ramy on 11/29/19.
//  Copyright © 2019 Ahmed Ramy. All rights reserved.
//

import XCTest

@testable import Cognitev_Task

class BaseSceneTests: XCTestCase {
    
    var router: RouterMock!
    var cache: CacheMock!
    var network: NetworkMock!
    var location: LocationMock!
    
    override func setUp() {
        cache = CacheMock()
        router = RouterMock()
        network = NetworkMock()
        location = LocationMock()
        CommandLine.arguments.append("Testing")
    }
    
    override func tearDown() {
        super.tearDown()
        Reachability.testingValue = nil
        CommandLine.arguments.removeFirst(where: { $0 == "Testing" })
    }
    
    func testBaseInteractorHandlesReachability() {
        // Given
        let interactor = BaseInteractor(network: network, cache: cache)
        Reachability.testingValue = false
        
        // When
        do {
         try interactor.validate()
        } catch let error {
            let expectedError = ValidationError.unreachable.localizedDescription
            XCTAssertEqual(error.localizedDescription, expectedError)
        }
    }
}
