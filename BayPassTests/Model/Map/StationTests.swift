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
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_Station_BuildsThePath() {
        let name = "Test"
        let code = 2
        let transitModes = [TransitMode.bart]
        let loc: CLLocation = CLLocation(latitude: 0.0, longitude: 0.0)
        let lines = ["line"]
        let subject = Station(name: name, code: code, transitModes: transitModes, lines: lines, location: loc)
        
        XCTAssertEqual(subject.name, "Test")
        XCTAssertEqual(subject.code, 2)
        XCTAssertEqual(subject.transitModes, transitModes)
        XCTAssertEqual(subject.location, loc)
        XCTAssertEqual(subject.lines, lines)
    }
}
