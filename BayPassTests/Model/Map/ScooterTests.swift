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
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

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
}
