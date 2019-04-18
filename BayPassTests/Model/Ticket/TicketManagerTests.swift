//
//  TicketManagerTests.swift
//  BayPassTests
//
//  Created by Tim Roesner on 4/17/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

@testable import BayPass
import XCTest

class TicketManagerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCalTrainZonesFailure() {
        let zones = TicketManager.shared.calculateCalTrainZones(from: "", to: "")
        XCTAssertEqual(zones, 0)
    }

}
