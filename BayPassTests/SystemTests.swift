//
//  StationTests.swift
//  BayPassTests
//
//  Created by Ayesha Khan on 4/6/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

@testable import BayPass
import CoreLocation
import XCTest

class SystemTests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetAllStations() {
        let subject = System()
        let results = subject.getAllStations()
        XCTAssertNotNil(results)
    }
}
