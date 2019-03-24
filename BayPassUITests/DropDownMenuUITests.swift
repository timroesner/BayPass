//
//  DropDownMenuUITests.swift
//  BayPassUITests
//
//  Created by Zhe Li on 3/23/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import XCTest

class DropDownMenuUITests: XCTestCase {
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
    
    func testDropDownMenuHeight() {
        
        let app = XCUIApplication()
        
        app.tabBars.buttons["Ticket"].tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .button).element(boundBy: 0).tap()
        
        let tablesQuery = app.tables
        
        let paypalStaticText = tablesQuery.children(matching: .cell).element(boundBy: 2).staticTexts["Paypal"]
        paypalStaticText.swipeUp()
        tablesQuery.children(matching: .cell).element(boundBy: 3).staticTexts["Venmo"].swipeDown()
        
        paypalStaticText.tap()
        
    }
        
}
