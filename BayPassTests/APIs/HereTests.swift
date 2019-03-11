//
//  HereTests.swift
//  BayPassTests
//
//  Created by Ayesha Khan on 3/10/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import Alamofire
@testable import BayPass
import CoreLocation
import UIKit
import XCTest

class HereTests: XCTestCase {
    var testJson: [String: Any] = [:]

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetStationIds() {
        let ex = expectation(description: "Here for getting Station Ids")
        let center = CLLocationCoordinate2D(latitude: 37.5032238, longitude: -121.9434281)
        let radius = 1500
        let max = 1

        var results: [Int]?

        Here().getStationIds(center: center, radius: radius, max: max) { res in
            results = res
            ex.fulfill()
        }
        wait(for: [ex], timeout: 30)
        XCTAssertEqual(results!, [718_310_131])
    }

    func testGetAgencyFromStationId() {
        let ex = expectation(description: "Here for getting Agency")
        let stationId: Int = 718_310_131

        var result: Agency?

        Here().getAgencyFromStationId(stationId: stationId) { resp in
            result = resp
            ex.fulfill()
        }
        wait(for: [ex], timeout: 30)
        XCTAssertEqual(result!, Agency.BART)
    }
}
