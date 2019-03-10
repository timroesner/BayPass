//
//  ClipperCardTests.swift
//  BayPassTests
//
//  Created by Ayesha Khan on 10/28/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

@testable import BayPass
import CoreLocation
import XCTest

class ClipperCardTests: XCTestCase {
    var pass: Pass?

    override func setUp() {
        let loc: CLLocation = CLLocation(latitude: 21.35, longitude: 121.34)
        let lineX = [Line(name: "Green", agency: Agency.BART, destination: "Milbrae", color: #colorLiteral(red: 0.2901960784, green: 0.5647058824, blue: 0.8862745098, alpha: 1), transitMode: TransitMode.bart)]
        let station = Station(name: "SFO", code: 2, transitModes: [TransitMode.bart], lines: lineX, location: loc)
        let agency = Agency(rawValue: "BA")
        pass = Pass(name: "BART", duration: DateInterval(), price: 2.3, validOnAgency: agency ?? Agency.zero)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_ClipperCard_BuildsThePath() {
        let num: Int = 3
        let cash: Double = 2.3
        let subject = ClipperCard(number: num, cashValue: cash, passes: [pass!])

        XCTAssertEqual(subject.number, num)
        XCTAssertEqual(subject.cashValue, cash)
        XCTAssertEqual(subject.passes.count, 1)
    }

    func testAddCash() {
        var testCard = ClipperCard(number: 234_529_573_913, cashValue: 0.75, passes: [])
        testCard.addCash(amount: 5.00)
        assert(testCard.cashValue == 5.75)
    }

    func testAddPass() {
        var testCard = ClipperCard(number: 234_529_573_913, cashValue: 0.75, passes: [])
        testCard.addPass(new: pass!)
        assert(testCard.passes.last?.name == "BART")
        assert(testCard.passes.last?.price == 2.3)
    }
}
