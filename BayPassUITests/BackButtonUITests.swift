//
//  BackButtonUITests.swift
//  BayPassUITests
//
//  Created by 凌脩羽 on 3/6/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import XCTest

class BackButtonUITests: XCTestCase {
    
    override func setUp() {
        continueAfterFailure = false
        
        // Set this launch argument to speed up tests
        let app = XCUIApplication()
        app.launchArguments = ["UITests"]
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testBackButton () {
        
        let app = XCUIApplication()
        let tabBarsQuery = app.tabBars
        
        //Ticket
        tabBarsQuery.buttons["Ticket"].tap()
        app.buttons["ticket checkout"].tap()
        app.navigationBars["Ticket Checkout"].buttons["Tickets"].tap()
        
        //Clipper
        tabBarsQuery.buttons["Clipper"].tap()
        app.buttons["add cash value"].tap()
        app.navigationBars["Add Cash Value"].buttons["Clipper"].tap()
        
    }
    
}
