//
//  DestinationRoutingTests.swift
//  BayPassUITests
//
//  Created by Tim Roesner on 3/7/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import XCTest

class DestinationRoutingTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        let app = XCUIApplication()
        app.launch()
        let locationAlert = app.alerts.firstMatch
        if locationAlert.exists {
            locationAlert.buttons["Allow"].tap()
        }
        //app.tap()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBottomDrawer() {
        let app = XCUIApplication()
        let searchSearchField = app.searchFields["Search"]
        searchSearchField.tap()
        
        let cancelButton = app.buttons["Cancel"]
        cancelButton.tap()
        
        let bottomDrawer = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 2).children(matching: .other).element.children(matching: .other).element.children(matching: .other).children(matching: .other).element(boundBy: 0)
        
        bottomDrawer.swipeUp()
        bottomDrawer.swipeDown()
    }
    
    func testSearchDestination() {
        let app = XCUIApplication()
        
        let searchSearchField = app.searchFields["Search"]
        searchSearchField.tap()
        searchSearchField.typeText("Apple")
        
        let searchButton = app.buttons["Search"]
        searchButton.tap()
        
        let cell = app.tables.cells.firstMatch
        cell.tap()
        
        let scrollView = app.scrollViews.firstMatch
        scrollView.swipeLeft()
        scrollView.swipeLeft()
        scrollView.swipeLeft()
        scrollView.swipeRight()
        scrollView.swipeRight()
        scrollView.swipeRight()
        
        let cancelButton = app.buttons["Cancel"]
        cancelButton.tap()
    }

}
