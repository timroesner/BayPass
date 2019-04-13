//
//  DropDownMenuTests.swift
//  BayPassTests
//
//  Created by Zhe Li on 3/6/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

@testable import BayPass
import XCTest
import SnapKit

class DropDownMenuTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testTitleUpperCase() {
        let dropDown = DropDownMenu(title: "Payment method", items: ["Apple Pay", "Credit/Debit", "Paypal"])
        XCTAssertEqual(dropDown.titleLbl.text, "PAYMENT METHOD")
    }
    
    func testDropDownTableView() {
        let dropDown1 = DropDownMenu(title: "Payment method", items: ["Apple Pay", "Credit/Debit"])
        XCTAssertEqual(dropDown1.tableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(dropDown1.tableView.dataSource?.tableView(dropDown1.tableView, cellForRowAt: IndexPath(row: 0, section: 0)).textLabel?.text, "Credit/Debit")
        XCTAssertEqual(dropDown1.tableView.dataSource?.tableView(dropDown1.tableView, cellForRowAt: IndexPath(row: 0, section: 0)).textLabel?.font, UIFont.systemFont(ofSize: 20, weight: .bold))
        
        let dropDown2 = DropDownMenu(title: "Payment method", items: ["Apple Pay", "Credit/Debit", "Paypal", "Venmo", "Cash"])
        XCTAssertEqual(dropDown2.tableView.numberOfRows(inSection: 0), 4)
        XCTAssertEqual(dropDown2.tableView.isScrollEnabled, true)
        XCTAssertEqual(dropDown2.tableView.dataSource?.tableView(dropDown2.tableView, cellForRowAt: IndexPath(row: 1, section: 0)).textLabel?.text, "Paypal")
    }
    
    func testSelectedItem() {
        let dropDown = DropDownMenu(title: "Payment method", items: ["Apple Pay", "Credit/Debit"])
        XCTAssertEqual(dropDown.getSelectedItem(), "Apple Pay")
    }
    
    func testHeight() {
        let dropDown2 = DropDownMenu(title: "Payment method", items: ["Apple Pay", "Credit/Debit", "Paypal", "Venmo", "Cash"])
        let initialHeight = dropDown2.tableView.frame.height
        XCTAssert(initialHeight == 0)
        dropDown2.handleTap()
    }
    
}
