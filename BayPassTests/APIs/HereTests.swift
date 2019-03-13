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

    override func setUp() {
        let path = Bundle(for: type(of: self)).path(forResource: "Here", ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)
        testJson = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]

        let pathForAgency = Bundle(for: type(of: self)).path(forResource: "HereAgency", ofType: "json")
        let dataForAgency = try! Data(contentsOf: URL(fileURLWithPath: pathForAgency!), options: .mappedIfSafe)
        testJsonForAgency = try! JSONSerialization.jsonObject(with: dataForAgency, options: .allowFragments) as! [String: Any]
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
        let station = [Station(name: "Warm Springs/South Fremont", code: 718_310_131, transitModes: [TransitMode.bus], lines: [Line(name: "22", agency: Agency.VTA, destination: "22 Palo Alto", color: #colorLiteral(red: 0.2901960784, green: 0.5647058824, blue: 0.8862745098, alpha: 1), transitMode: TransitMode.bus)], location: CLLocation(latitude: 37.352516, longitude: -121.96947))]

        var results: [Station]? = [Station]()

        Here().getStationsNearby(center: center, radius: radius, max: 1) { resp in
            results = resp
            ex.fulfill()
        }
        wait(for: [ex], timeout: 5)
        XCTAssertNotNil(results!) // TODO: FIX
        XCTAssertEqual(results![0].name, "Warm Springs/South Fremont")
        XCTAssertEqual(results![0].code, 718_310_131)
        XCTAssertEqual(results![0].lines[0].transitMode, TransitMode.lightRail)
        XCTAssertEqual(results![0].lines[0].name, "Green")
        XCTAssertEqual(results![0].lines[0].destination, "Warm Springs/South Fremont")
        XCTAssertEqual(results![0].lines[0].color, UIColor(hexString: "#339933"))
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
        XCTAssertEqual(results![0].name, "Green")
        XCTAssertEqual(results![0].destination, "Daly City")
        XCTAssertEqual(results![0].transitMode, TransitMode.lightRail)
    }

    func testParseStationForId() {
        let resJson = testJson["Res"] as! [String: Any]
        let stationsJson = resJson["Stations"] as! [String: Any]
        let stnsJson = stationsJson["Stn"] as! [[String: Any]]

        let test = Here().parseStationForId(from: stnsJson[0])

        XCTAssertEqual(test, 718_290_976)
    }

    func testParseOperatorFromStationId() {
        let resJson = testJsonForAgency["Res"] as! [String: Any]
        let multiNextDepartures = resJson["MultiNextDepartures"] as! [String: Any]
        let multiNextDeparture = multiNextDepartures["MultiNextDeparture"] as! [[String: Any]]

        let test = Here().parseOperatorFromStationId(from: multiNextDeparture[0])

        XCTAssertEqual(test, Agency.SamsTrans)
    }

    func testParseStation() {
        let loc = CLLocation(latitude: -122.5353, longitude: 37.935921)
        let resJson = testJson["Res"] as! [String: Any]
        let stationsJson = resJson["Stations"] as! [String: Any]
        let stnsJson = stationsJson["Stn"] as! [[String: Any]]

        let test = Here().parseStation(from: stnsJson[0])

        XCTAssertEqual(test?.code, 718_290_976)
        XCTAssertEqual(test?.name, "Magnolia Ave & Ward St")
        XCTAssertNotNil(test?.lines)
        XCTAssertEqual(test?.transitModes, [TransitMode.bus])
        XCTAssertNotNil(test?.location)
    }

    func testTransitModeConvert() {
        let num = 4
        let num1 = 5
        let num2 = 3
        let num3 = 8

        XCTAssertEqual(Here().transitModeConvert(num: num), TransitMode.lightRail)
        XCTAssertEqual(Here().transitModeConvert(num: num1), TransitMode.bus)
        XCTAssertEqual(Here().transitModeConvert(num: num2), TransitMode.calTrain)
        XCTAssertEqual(Here().transitModeConvert(num: num3), TransitMode.bart)
    }
}
