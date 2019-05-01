//
//  TicketDetailViewControllerTests.swift
//  BayPassTests
//
//  Created by 凌脩羽 on 4/24/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

@testable import BayPass
import XCTest

class TicketDetailViewControllerTests: XCTestCase {
    let vc = TicketDetailViewController(ticket: Ticket(name: "Single Ride - 3 Zones", count: 1, price: 9.75, validOnAgency: .CalTrain))
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        UIApplication.shared.keyWindow!.rootViewController = vc
        XCTAssertNotNil(UIApplication.shared.keyWindow?.rootViewController)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testScanButton() {
        vc.scanTicket()
        XCTAssertNotNil(vc.session)
    }

}
