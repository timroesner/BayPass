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
        wait(for: [ex], timeout: 5)
        XCTAssertEqual(results!, [718_310_131])
    }

    func testGetAgencyFromStationId() {
        let ex = expectation(description: "Here for getting Agency")
        let stationId: Int = 718_310_131
        let time = "2019-06-24T08%3A00%3A00"
        var result: Agency?

        Here().getAgencyFromStationId(stationId: stationId, time: time) { resp in
            result = resp
            ex.fulfill()
        }
        wait(for: [ex], timeout: 5)
        XCTAssertEqual(result!, Agency.BART)
    }

    func testGetStationsNearby() {
        let ex = expectation(description: "Here for getting Station Ids")
        let center = CLLocationCoordinate2D(latitude: 37.5032238, longitude: -121.9434281)
        let radius = 1500
        let max = 1
        let station = Station(name: "Warm Springs/South Fremont", code: 718_310_131, transitModes: [TransitMode.bus], lines: [Line(name: "22", agency: Agency.VTA, destination: "22 Palo Alto", color: #colorLiteral(red: 0.2901960784, green: 0.5647058824, blue: 0.8862745098, alpha: 1), transitMode: TransitMode.bus)], location: CLLocation(latitude: 37.352516, longitude: -121.96947))

        var results: [Station]? = [Station]()

        Here().getStationsNearby(center: center, radius: radius, max: 1) { resp in
            results = resp
            ex.fulfill()
        }
        wait(for: [ex], timeout: 5)
        XCTAssertNotNil(results!) // TODO: FIX
//        XCTAssertEqual(results, [station])
    }

    func testGetLine() {
        let ex = expectation(description: "Here for getting Line from a Station ID")
        let stationId: Int = 718_310_131
        let time = "2019-06-24T08%3A00%3A00"

        var results: [Line]?
        Here().getLine(stationId: stationId, time: time) { resp in
            results = resp
            ex.fulfill()
        }

        wait(for: [ex], timeout: 5)
//        XCTAssertEqual(results!, )
//        XCTAssertEqual(, )
    }
}
