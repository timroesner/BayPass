//
//  ClipperPassUITests.swift
//  BayPassUITests
//
//  Created by Zhe Li on 4/16/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import XCTest

class ClipperPassUITests: XCTestCase {
    
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
    
    func testSelectClipperPass() {
        
        let app = XCUIApplication()
        app.tabBars.buttons["Clipper"].tap()
        app.buttons["Create new Virtual Card"].tap()
        app.collectionViews.cells.otherElements.containing(.staticText, identifier:"Add").element.tap()
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.children(matching: .collectionView).element(boundBy: 1).children(matching: .cell).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.tap()
        app.navigationBars["VTA"].buttons["Add Pass"].tap()
        element.children(matching: .collectionView).element(boundBy: 0).children(matching: .cell).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.tap()
        app.navigationBars["BART"].buttons["Add Pass"].tap()
        
        
    }
    
    
}
