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
        agency = Agency.BART
    }

    override func tearDown() {
        agency = nil
    }

    func test_Ticket_BuildsThePath() {
        let name = "some"
        let dur = DateInterval()
        let cost = 2.3
        let subject = Ticket(name: name, duration: dur, price: cost, validOnAgency: agency!)

        XCTAssertEqual(subject.name, "some")
        XCTAssertEqual(subject.duration, dur)
        XCTAssertEqual(subject.price, 2.3)
    }

    func testIsValidTrue() {
        let testTicket = Ticket(name: "VTA", count: 1, price: 2.50, validOnAgency: agency!)
        assert(testTicket.isValid())
    }

    func testIsValidFalse() {
        let duration = DateInterval(start: Date(timeIntervalSince1970: 60), duration: 45)
        let testTicket = Ticket(name: "VTA", duration: duration, price: 2.50, validOnAgency: agency!)
        assert(testTicket.isValid() == false)
    }
}
