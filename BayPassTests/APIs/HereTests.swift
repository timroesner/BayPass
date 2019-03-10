//
//  HereTests.swift
//  BayPassTests
//
//  Created by Ayesha Khan on 3/10/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

@testable import BayPass
import CoreLocation
import UIKit
import XCTest

class HereTests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetStationIds() {
        let ex = expectation(description: "Here getStationIds")
        let center = CLLocationCoordinate2D(latitude: 37.5032238, longitude: -121.9434281)
        let radius = 4000
        let max = 20

        let here = Here()
        here.getStationIds(center: center, radius: radius, max: max) { resp in
            XCTAssertEqual(resp, [718_310_131, 417_005_875, 417_006_013, 417_005_874, 401_908_233, 401_908_224, 417_000_085, 417_000_402, 417_004_457, 417_000_097, 417_000_056, 417_001_815, 417_001_651, 417_001_286, 417_004_737, 417_002_683, 417_004_114, 417_001_449, 417_001_967, 417_001_397])
        }
//        waitForExpectations(timeout: 5.0, handler: nil)
    }
}
