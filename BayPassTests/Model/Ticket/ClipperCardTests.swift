//
//  ClipperCardTests.swift
//  BayPassTests
//
//  Created by Ayesha Khan on 10/28/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

@testable import BayPass
import CoreLocation
import XCTest

class ClipperCardTests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_ClipperCard_BuildsThePath() {
        let num: Int = 3
        let cash: Double = 2.3
        let loc: CLLocation = CLLocation(latitude: 0.0, longitude: 0.0)
        let passes: [Pass] = [Pass(name: "name", duration: DateInterval(), price: 2.3, validOnAgency: Agency(name: "Some", routes: [Line(name: "some", code: 2, destination: "dest", stops: [Station(name: "some", code: 2, transitModes: [TransitMode.bart], lines: ["some"], location: loc)])]))]
        
        let subject = ClipperCard(number: num, cashValue: cash, passes: passes)
        
        XCTAssertEqual(subject.number, 3)
        XCTAssertEqual(subject.cashValue, 2.3)
    }
}
