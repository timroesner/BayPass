//
//  BartTests.swift
//  BayPassTests
//
//  Created by Tim Roesner on 2/2/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

@testable import BayPass
import XCTest

class BartTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetFare() {
        let expectation = self.expectation(description: "async")
        var result = 0.0
        BART().getFare(from: "sfia", to: "pitt", completion: {
            result = $0
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(result, 12.35)
    }

}
