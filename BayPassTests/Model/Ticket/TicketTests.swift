//
//  TicketTests.swift
//  BayPassTests
//
//  Created by Ayesha Khan on 10/28/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

@testable import BayPass
import CoreLocation
import XCTest

class TicketTests: XCTestCase {
    var agency: Agency?
    var locations = [CLLocation]()

    override func setUp() {
        let loc: CLLocation = CLLocation(latitude: 21.35, longitude: 121.34)
        let lineX = [Line(name: "Green", agency: Agency.BART, destination: "Milbrae", color: #colorLiteral(red: 0.2901960784, green: 0.5647058824, blue: 0.8862745098, alpha: 1), transitMode: TransitMode.bart)]

        let station = Station(name: "SFO", code: 2, transitModes: [TransitMode.bart], lines: lineX, location: loc)
        agency = Agency(rawValue: "BA")
        locations = [loc]
    }

    override func tearDown() {
        agency = nil
    }

    func test_Ticket_BuildsThePath() {
        let name = "some"
        let dur = DateInterval()
        let cost = 2.3
        let code = "234"
        let subject = Ticket(name: name, duration: dur, price: cost, validOnAgency: agency!, NFCCode: code, locations: locations)

        XCTAssertEqual(subject.name, "some")
        XCTAssertEqual(subject.duration, dur)
        XCTAssertEqual(subject.price, 2.3)
        XCTAssertEqual(subject.locations, locations)
        XCTAssertEqual(subject.NFCCode, code)
    }

    func testIsValidTrue() {
        let testTicket = Ticket(name: "VTA", count: 1, price: 2.50, validOnAgency: agency!, NFCCode: "1234", locations: locations)
        assert(testTicket.isValid())
    }

    func testIsValidFalse() {
        let duration = DateInterval(start: Date(timeIntervalSince1970: 60), duration: 45)
        let testTicket = Ticket(name: "VTA", duration: duration, price: 2.50, validOnAgency: agency!, NFCCode: "1234", locations: locations)
        assert(testTicket.isValid() == false)
    }
}
