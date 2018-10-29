//
//  BikeDockTests.swift
//  BayPassTests
//
//  Created by Ayesha Khan on 10/28/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

@testable import BayPass
import CoreLocation
import XCTest

class BikeDockTests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_BikeDock_BuildsThePath() {
        let loc: CLLocation = CLLocation(latitude: 0.0, longitude: 0.0)
        let bikeAvail: Int = 2
        
        let subject = BikeDock(location: loc, bikesAvailible: bikeAvail)
        
        XCTAssertEqual(subject.location, loc)
        XCTAssertEqual(subject.bikesAvailible, 2)
    }
}
