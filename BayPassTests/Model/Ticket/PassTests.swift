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
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
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
}
