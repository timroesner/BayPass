//
//  Scooter.swift
//  BayPassTests
//
//  Created by Ayesha Khan on 10/28/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

@testable import BayPass
import CoreLocation
import XCTest

class ScooterTests: XCTestCase {
    func test_Scooter_BuildsThePath() {
        let code = "ran"
        let loc: CLLocation = CLLocation(latitude: 0.0, longitude: 0.0)
        let batt = "23%"
        let company = ScooterCompany(name: "Bird")

        let subject = Scooter(code: code, location: loc, battery: batt, company: company)

        XCTAssertEqual(subject.code, "ran")
        XCTAssertEqual(subject.location, loc)
        XCTAssertEqual(subject.battery, batt)
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
