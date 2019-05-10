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
    var testJsonForAgency: [String: Any] = [:]
    var testJsonForDepTime: [String: Any] = [:]
    let here = Here.shared
    override func setUp() {
        let path = Bundle(for: type(of: self)).path(forResource: "Here", ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)
        testJson = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]

        let pathForAgency = Bundle(for: type(of: self)).path(forResource: "HereAgency", ofType: "json")
        let dataForAgency = try! Data(contentsOf: URL(fileURLWithPath: pathForAgency!), options: .mappedIfSafe)
        testJsonForAgency = try! JSONSerialization.jsonObject(with: dataForAgency, options: .allowFragments) as! [String: Any]
        let pathForDepTime = Bundle(for: type(of: self)).path(forResource: "HereDepTime", ofType: "json")
        let dataForDepTime = try! Data(contentsOf: URL(fileURLWithPath: pathForDepTime!), options: .mappedIfSafe)
        testJsonForDepTime = try! JSONSerialization.jsonObject(with: dataForDepTime, options: .allowFragments) as! [String: Any]
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetStationsNearby() {
        let ex = expectation(description: "Here for getting Station Ids")
        let center = CLLocationCoordinate2D(latitude: 37.5032238, longitude: -121.9434281)
        let radius = 1500

        var results: [Station]? = [Station]()

        here.getStationsNearby(center: center, radius: radius, max: 1) { resp in
            results = resp
            ex.fulfill()
        }
        wait(for: [ex], timeout: 5)
        XCTAssertNotNil(results!)
        XCTAssertEqual(results![0].name, "Warm Springs/South Fremont")
        XCTAssertEqual(results![0].code, 718_310_131)
    }

    func testGetDepartureTimes() {
        let ex = expectation(description: "Here for getting Line from a Station ID")
        let stationId: Int = 718_310_131

        var results: [(line: Line, departureTimes: [Date])]?
        here.getDepartureTimesForAStation(stationId: stationId, completion: { (result) in
            results = result
            ex.fulfill()
        })
        wait(for: [ex], timeout: 5)
        XCTAssertNotNil(results)
    }

    func testParseTimesFromStationIds() {
        var times: (line: Line, departureTimes: [Date])?

        let resJson = testJsonForDepTime["Res"] as? [String: Any]
        let multiNextDepartures = resJson?["MultiNextDepartures"] as? [String: Any]
        let multiNextDeparture = multiNextDepartures?["MultiNextDeparture"] as? [[String: Any]]
        for mul in multiNextDeparture! {
            times = here.parseTimingsFromStationId(from: mul)
        }
        XCTAssertNotNil(times)
    }

    func testParseStation() {
        let resJson = testJson["Res"] as! [String: Any]
        let stationsJson = resJson["Stations"] as! [String: Any]
        let stnsJson = stationsJson["Stn"] as! [[String: Any]]

        let test = here.parseStation(from: stnsJson[0])

        XCTAssertEqual(test?.code, 718_290_976)
        XCTAssertEqual(test?.name, "Magnolia Ave & Ward St")
        XCTAssertNotNil(test?.lines)
        XCTAssertEqual(test?.transitModes, [TransitMode.bus])
        XCTAssertNotNil(test?.location)
    }

    func testTransitModeConvert() {
        let num = 7
        let num1 = 5
        let num2 = 3
        let num3 = 8
        let num4 = 1

        XCTAssertEqual(here.transitModeConvert(num: num), TransitMode.bart)
        XCTAssertEqual(here.transitModeConvert(num: num1), TransitMode.bus)
        XCTAssertEqual(here.transitModeConvert(num: num2), TransitMode.calTrain)
        XCTAssertEqual(here.transitModeConvert(num: num3), TransitMode.lightRail)
        XCTAssertEqual(here.transitModeConvert(num: num4), TransitMode.bus)
    }
}
