//
//  PurchesedTicketCellTests.swift
//  BayPassTests
//
//  Created by Zhe Li on 2/27/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

@testable import BayPass
import CoreLocation
import SnapKit
import XCTest

class PurchasedTicketCellTests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSetup() {
        let agency = Agency.BART
        let name = "Monthly Pass"
        let dur = DateInterval(start: Date(timeIntervalSince1970: 60), duration: 30)
        let cost = 2.3
        let ticket = Ticket(name: name, duration: dur, price: cost, validOnAgency: agency)

        let cell = PurchasedTicketCell()
        cell.setup(with: ticket)

        XCTAssertEqual(cell.nameLbl.text, "Monthly Pass")
        XCTAssertEqual(cell.durationLbl.text, "Valid until December 31")
        XCTAssertEqual(cell.ticketView.nameLbl.text, "BART")
    }
}
