//
//  CoderInitTests.swift
//  BayPassTests
//
//  Created by Tim Roesner on 3/13/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

@testable import BayPass
import XCTest

class CoderInitTests: XCTestCase {
    
    var archiver = NSCoder()

    override func setUp() {
        let archiverData = NSMutableData()
        archiver = NSKeyedArchiver(forWritingWith: archiverData)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTicketView() {
        let ticketView = TicketView(coder: archiver)
        XCTAssertNil(ticketView)
    }
    
    func testSearchFloatView() {
        let searchFloat = SearchFloatView(coder: archiver)
        XCTAssertNil(searchFloat)
    }
    
    func testCustomTextField() {
        let txtField = CustomTextField(coder: archiver)
        XCTAssertNil(txtField)
    }
    
    func testPurchasedTicketCell() {
        let purchasedTicketCell = PurchasedTicketCell(coder: archiver)
        XCTAssertNil(purchasedTicketCell)
    }
    
    func testClipperView() {
        let clipperView = ClipperView(coder: archiver)
        XCTAssertNil(clipperView)
    }
    
    func testRouteOverView() {
        let routeOverView = RouteOverView(coder: archiver)
        XCTAssertNil(routeOverView)
    }
    
    func testMoveIndicator() {
        let moveIndicator = MoveIndicator(coder: archiver)
        XCTAssertNil(moveIndicator)
    }
    
    func testDestinationSearchResultTableViewCell() {
        let cell = DestinationSearchResultTableViewCell(coder: archiver)
        XCTAssertNil(cell)
    }
    
    func testEmptyView() {
        let emptyView = EmptyView(coder: archiver)
        XCTAssertNil(emptyView)
    }
    
    func testStationSearchResultTableViewCell() {
        let cell = StationSearchResultTableViewCell(coder: archiver)
        XCTAssertNil(cell)
    }
    
    func testBayPassButton() {
        let button = BayPassButton(coder: archiver)
        XCTAssertNil(button)
    }
    
    func testProgressHUD() {
        let progressHUD = ProgressHUD(coder: archiver)
        XCTAssertNil(progressHUD)
    }
    
    func testClipperPassCell() {
        let cell = ClipperPassCollectionViewCell(coder: archiver)
        XCTAssertNil(cell)
    }

}
