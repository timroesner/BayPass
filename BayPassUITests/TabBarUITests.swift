//
//  BayPassUITests.swift
//  BayPassUITests
//
//  Created by Tim Roesner on 9/14/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

import XCTest

class TabBarUITests: XCTestCase {
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

    // Normally I would put these into 3 different test, but since
    // setUp takes significant time I am putting them together for speed
    
    // Once we start implementing we need to test different which screen is displayed
    // The navigation bar title might be an option
    func testTabBar() {
        let tabBarsQuery = XCUIApplication().tabBars
        
        // Map
        tabBarsQuery.buttons["Map"].tap()
        let mapLabel = XCUIApplication().staticTexts["Map"]
        XCTAssert(mapLabel.exists)
        
        // Ticket
        tabBarsQuery.buttons["Ticket"].tap()
        let ticketsTitle =  XCUIApplication().navigationBars["Tickets"].otherElements["Tickets"]
        XCTAssert(ticketsTitle.exists)
        
        // Clipper
        tabBarsQuery.buttons["Clipper"].tap()
        let clipperTitle = XCUIApplication().navigationBars["Clipper"].otherElements["Clipper"]
        XCTAssert(clipperTitle.exists)    }
}
