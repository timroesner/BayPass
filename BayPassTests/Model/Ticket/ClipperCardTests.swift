//
//  ClipperCardTests.swift
//  BayPassTests
//
//  Created by Ayesha Khan on 10/28/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

@testable import BayPass
import XCTest

class ClipperCardTests: XCTestCase {
    func test_ClipperCard_BuildsThePath() {
        let num: Int = 3
        let cash: Double = 2.3
        let passes: [Pass] = [Pass(name: "name", duration: DateInterval(), price: 2.3, validOnAgency: Agency())]

        XCTAssertEqual(subject.name, "Test")
    }

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
