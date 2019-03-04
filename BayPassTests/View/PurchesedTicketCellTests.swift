//
//  PurchesedTicketCellTests.swift
//  BayPassTests
//
//  Created by Zhe Li on 2/27/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

@testable import BayPass
import XCTest
import SnapKit
import CoreLocation

class PurchesedTicketCellTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSetup() {
        let loc: CLLocation = CLLocation(latitude: 21.35, longitude: 121.34)
        let station = Station(name: "SFO", code: 2, transitModes: [TransitMode.bart], lines: ["Green"], location: loc)
        let line = Line(name: "Green", code: 2, destination: "Milbrae", stops: [station])
        let agency = Agency(name: "BART", routes: [line], icon: UIImage(named: "CalTrain")!)
        let locations = [loc]
        
        let name = "Monthly Pass"
        let dur = DateInterval()
        let cost = 2.3
        let code = "234"
        let ticket = Ticket(name: name, duration: dur, price: cost, validOnAgency: agency, NFCCode: code, locations: locations)
        
        let cell = PurchesedTicketCell()
        cell.setup(with: ticket)
        
        XCTAssertEqual(cell.nameLbl.text, "Monthly Pass")
        XCTAssertEqual(cell.durationLbl.text, "Valid until 3/3/19")
        XCTAssertEqual(cell.ticketView.nameLbl.text, "BART")
        
    }

}
