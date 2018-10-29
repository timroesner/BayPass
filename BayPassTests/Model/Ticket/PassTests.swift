//
//  PassTests.swift
//  BayPassTests
//
//  Created by Ayesha Khan on 10/28/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

@testable import BayPass
import CoreLocation
import XCTest

class PassTests: XCTestCase {
    func test_Pass_BuildsThePath() {
        let name = "some"
        let dur = DateInterval()
        let cost = 2.3
        let loc: CLLocation = CLLocation(latitude: 0.0, longitude: 0.0)
        let agency = Agency(name: "Some", routes: [Line(name: "some", code: 2, destination: "dest", stops: [Station(name: "some", code: 2, transitModes: [TransitMode.bart], lines: ["some"], location: loc)])])
        let subject = Pass(name: name, duration: dur, price: cost, validOnAgency: agency)

        XCTAssertEqual(subject.name, "some")
        XCTAssertEqual(subject.duration, dur)
        XCTAssertEqual(subject.price, 2.3)
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
