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
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
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
        
        app.keys["A"].tap()
        app.keys["p"].tap()
        app.keys["p"].tap()
        app.keys["l"].tap()
        app.keys["e"].tap()
        
        let searchButton = app/*@START_MENU_TOKEN@*/.keyboards.buttons["Search"]/*[[".keyboards.buttons[\"Search\"]",".buttons[\"Search\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
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
