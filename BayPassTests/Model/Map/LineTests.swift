//
//  LineTests.swift
//  BayPassTests
//
//  Created by Ayesha Khan on 10/28/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

@testable import BayPass
import CoreLocation
import XCTest

class LineTests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_Line_BuildsThePath() {
        let name = "Test"
        let dest = "ran"
        let loc: CLLocation = CLLocation(latitude: 0.0, longitude: 0.0)
        let stopsTest = [Station(name: "r", code: 3, transitModes: [TransitMode.bus], lines: [Line(name: "n", agency: Agency.zero, destination: "m", color: #colorLiteral(red: 0.2901960784, green: 0.5647058824, blue: 0.8862745098, alpha: 1), transitMode: TransitMode.bus)], location: loc)]

        let subject = Line(name: name, agency: Agency.BART, destination: dest, color: #colorLiteral(red: 0.2901960784, green: 0.5647058824, blue: 0.8862745098, alpha: 1), transitMode: TransitMode.bart)
        XCTAssertEqual(subject.name, name)
        XCTAssertEqual(subject.agency, Agency.BART)
        XCTAssertEqual(subject.destination, dest)
        XCTAssertEqual(subject.transitMode, TransitMode.bart)
    }
}
