//
//  StationTests.swift
//  BayPassTests
//
//  Created by Ayesha Khan on 10/28/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

@testable import BayPass
import CoreLocation
import XCTest

class StationTests: XCTestCase {
    func test_Station_BuildsThePath() {
        var name = "Test"
        var code = 2
        var transitModes = [TransitMode.bart]
        var loc: CLLocation = CLLocation(latitude: 0.0, longitude: 0.0)
        var lines = ["line"]
        var subject = Station(name: name, code: code, transitModes: transitModes, lines: lines, location: loc)

        XCTAssertEqual(subject.name, "Test")
        XCTAssertEqual(subject.code, 2)
        XCTAssertEqual(subject.transitModes, transitModes)
        XCTAssertEqual(subject.location, loc)
        XCTAssertEqual(subject.lines, lines)
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
