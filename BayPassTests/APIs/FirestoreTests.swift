//
//  FirestoreTests.swift
//  BayPassTests
//
//  Created by 凌脩羽 on 3/18/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

@testable import BayPass
import XCTest
import FirebaseFirestore

class FirestoreTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetTicketList() {
        let expectation = self.expectation(description: "async")
        var tickets = [Ticket]()
        var passes = [Pass]()
        let agency = Agency.SamTrans
        GoogleFirestore.shared.getTicketList(agency: agency, completion: { (tickets, passes) -> Void in
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
    }

}
