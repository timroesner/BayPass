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

        let subject = Line(name: name, agency: Agency.BART, destination: dest, color: #colorLiteral(red: 0.2901960784, green: 0.5647058824, blue: 0.8862745098, alpha: 1), transitMode: TransitMode.bart)
        XCTAssertEqual(subject.name, name)
        XCTAssertEqual(subject.agency, Agency.BART)
        XCTAssertEqual(subject.destination, dest)
        XCTAssertEqual(subject.transitMode, TransitMode.bart)
    }

    func testGetIcon() {
        let name = "Test"
        let dest = "ran"
        let subject = Line(name: name, agency: Agency.BART, destination: dest, color: #colorLiteral(red: 0.2901960784, green: 0.5647058824, blue: 0.8862745098, alpha: 1), transitMode: TransitMode.bart)
        let subject1 = Line(name: name, agency: Agency.BART, destination: dest, color: #colorLiteral(red: 0.2901960784, green: 0.5647058824, blue: 0.8862745098, alpha: 1), transitMode: TransitMode.bus)
        let subject2 = Line(name: name, agency: Agency.BART, destination: dest, color: #colorLiteral(red: 0.2901960784, green: 0.5647058824, blue: 0.8862745098, alpha: 1), transitMode: TransitMode.calTrain)
        let subject3 = Line(name: name, agency: Agency.BART, destination: dest, color: #colorLiteral(red: 0.2901960784, green: 0.5647058824, blue: 0.8862745098, alpha: 1), transitMode: TransitMode.lightRail)

        XCTAssertEqual(subject.getIcon(), #imageLiteral(resourceName: "BART"))
        XCTAssertEqual(subject1.getIcon(), #imageLiteral(resourceName: "Bus"))
        XCTAssertEqual(subject2.getIcon(), #imageLiteral(resourceName: "CalTrain"))
        XCTAssertEqual(subject3.getIcon(), #imageLiteral(resourceName: "Tram"))
    }
}
