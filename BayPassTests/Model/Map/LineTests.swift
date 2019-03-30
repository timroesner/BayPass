//
//  LineTests.swift
//  BayPassTests
//
//  Created by Ayesha Khan on 10/28/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

@testable import BayPass
import CoreLocation
import XCTest

class LineTests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_Line_BuildsThePath() {
        let name = "Test"
        let code = 2
        let dest = "ran"
        let loc: CLLocation = CLLocation(latitude: 0.0, longitude: 0.0)
        let stopsTest = [Station(name: "r", code: 3, transitModes: [TransitMode.bart], lines: ["some"], location: loc)]
        
        let subject = Line(name: name, code: code, destination: dest, stops: stopsTest)
        XCTAssertEqual(subject.code, code)
        XCTAssertEqual(subject.name, name)
        XCTAssertEqual(subject.destination, dest)
//        assert(subject.getStops() == stopsTest)
    }
}
