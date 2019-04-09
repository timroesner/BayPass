//
//  StationTests.swift
//  BayPassTests
//
//  Created by Ayesha Khan on 10/28/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

@testable import BayPass
import CoreLocation
import XCTest

class StationTests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_Station_BuildsThePath() {
        let name = "Test"
        let code = 2
        let transitModes = [TransitMode.bart]
        let loc: CLLocation = CLLocation(latitude: 0.0, longitude: 0.0)
        let linesX = [Line(name: "m", agency: Agency.ACE, destination: "n", color: #colorLiteral(red: 0.2901960784, green: 0.5647058824, blue: 0.8862745098, alpha: 1), transitMode: TransitMode.bart)]
        let subject = Station(name: name, code: code, transitModes: transitModes, lines: linesX, location: loc)

        XCTAssertEqual(subject.name, "Test")
        XCTAssertEqual(subject.code, 2)
        XCTAssertEqual(subject.transitModes, transitModes)
        XCTAssertEqual(subject.location, loc)
        XCTAssertNotNil(subject.lines)
    }

    func testGetDepartureTimes() {
        let code = 703_840_432
        let transitModes = [TransitMode.bart]
        let loc: CLLocation = CLLocation(latitude: 0.0, longitude: 0.0)
        let linesX = [Line(name: "m", agency: Agency.ACE, destination: "n", color: #colorLiteral(red: 0.2901960784, green: 0.5647058824, blue: 0.8862745098, alpha: 1), transitMode: TransitMode.bart)]
        let subject = Station(name: name, code: code, transitModes: transitModes, lines: linesX, location: loc)

        XCTAssertNotNil(subject.getDepartureTimes)
    }

    func testGetPrimaryTransitMode() {
        let name = "Test"
        let code = 2
        let transitModes = [TransitMode.bart]
        let loc: CLLocation = CLLocation(latitude: 0.0, longitude: 0.0)
        let linesX = [Line(name: "m", agency: Agency.ACE, destination: "n", color: #colorLiteral(red: 0.2901960784, green: 0.5647058824, blue: 0.8862745098, alpha: 1), transitMode: TransitMode.bart)]
        let subject = Station(name: name, code: code, transitModes: transitModes, lines: linesX, location: loc)

        XCTAssertEqual(subject.getPrimaryTransitMode(), TransitMode.bart)
    }

    func testBusIcon() {
        let station = Station(name: "5th & Santa Clara", code: 14, transitModes: [.bus], lines: [], location: CLLocation(latitude: 34.4, longitude: -121.3))
        assert(station.getIcon() == UIImage(named: "Bus"))
    }

    func testCalTrainIcon() {
        let station = Station(name: "Diridon", code: 12, transitModes: [.calTrain, .lightRail, .bus], lines: [], location: CLLocation(latitude: 34.3, longitude: -121.4))
        assert(station.getIcon() == UIImage(named: "CalTrain"))
    }

    func testBartIcon() {
        let station = Station(name: "Fremont", code: 232, transitModes: [.bart], lines: [], location: CLLocation(latitude: 36.3, longitude: -122.4))
        assert(station.getIcon() == UIImage(named: "BART"))
    }

    func testLightRailIcon() {
        let station = Station(name: "Santa Clara Station", code: 325, transitModes: [.lightRail, .bus], lines: [], location: CLLocation(latitude: 34.5, longitude: -121.7))
        assert(station.getIcon() == UIImage(named: "Tram"))
    }
}
