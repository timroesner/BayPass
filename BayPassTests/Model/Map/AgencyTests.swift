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
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_Agency_BuildsThePath() {
        let name = "Test"
        let subject = Agency(rawValue: "BA")

        XCTAssertEqual(subject?.rawValue, Agency.BART.rawValue)
    }
}
