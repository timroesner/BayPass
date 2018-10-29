//
//  AgencyTests.swift
//  BayPassTests
//
//  Created by Ayesha Khan on 10/28/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

@testable import BayPass
import CoreLocation
import XCTest

class AgencyTests: XCTestCase {
    func test_Agency_BuildsThePath() {
        var name = "Test"
        var loc: CLLocation = CLLocation(latitude: 0.0, longitude: 0.0)
        var routesT = [Line(name: "ran", code: 2, destination: "dest", stops: [Station(name: "ran", code: 3, transitModes: [TransitMode.bart], lines: ["line"], location: loc)])]

        var subject = Agency(name: name, routes: routesT)

        XCTAssertEqual(subject.name, name)
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