//
//  TicketViewControllerUITests.swift
//  BayPassUITests
//
//  Created by Zhe Li on 4/13/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import XCTest

class TicketViewControllerUITests: XCTestCase {
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

    func testSelectingTicket() {
        let app = XCUIApplication()
        let tabBarsQuery = app.tabBars
        tabBarsQuery.buttons["Map"].tap()
        tabBarsQuery.buttons["Ticket"].tap()
        app.collectionViews.cells.otherElements.containing(.staticText, identifier:"BART").element.tap()

        let dayPassStaticText = app.buttons["Single Ride"]
        dayPassStaticText.tap()
        dayPassStaticText.tap()
        app.navigationBars["BART"].buttons["Tickets"].tap()
    }
}
