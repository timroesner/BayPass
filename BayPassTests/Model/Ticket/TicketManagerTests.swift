//
//  TicketManagerTests.swift
//  BayPassTests
//
//  Created by Tim Roesner on 4/17/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

@testable import BayPass
import XCTest

class TicketManagerTests: XCTestCase {

    override func setUp() {
       
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCalTrainZonesFailure() {
        let price = TicketManager.shared.getCalTrainPrice(ticketType: "Single Ride", from: "", to: "")
        XCTAssertNil(price)
    }
    
    func testCalTrainPrice() {
        let price = TicketManager.shared.getCalTrainPrice(ticketType: "Single Ride", from: "San Jose Diridon", to: "San Francisco")
        XCTAssertEqual(price, 9.95)
    }
    
    func testDropDownOptionsCalTrain() {
        let options = TicketManager.shared.getDropDownOptions(for: .CalTrain, onlyPasses: false)
        XCTAssertEqual(options.count, 4)
    }
    
    func testDropDownOptionsVTA() {
        let options = TicketManager.shared.getDropDownOptions(for: .VTA, onlyPasses: true)
        XCTAssertEqual(options.count, 3)
    }
    
    func testPriceVTA() {
        let price = TicketManager.shared.getTicketPrice(agency: .VTA, ticketType: "Single Ride", subType: "Adult")
        XCTAssertEqual(price, 2.50)
    }
    
    func testPriceMuni() {
        let price = TicketManager.shared.getTicketPrice(agency: .Muni, ticketType: "Day Pass", subType: nil)
        XCTAssertEqual(price, 5.00)
    }

}
