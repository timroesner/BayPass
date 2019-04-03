//
//  ClipperAddCashTests.swift
//  BayPassTests
//
//  Created by Tim Roesner on 4/2/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

@testable import BayPass
import XCTest

class ClipperAddCashTests: XCTestCase {
    
    let vc = ClipperAddCashViewController()

    override func setUp() {
        UIApplication.shared.keyWindow!.rootViewController = vc
        XCTAssertNotNil(UIApplication.shared.keyWindow?.rootViewController)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTitle() {
        XCTAssertEqual(vc.title, "Add Cash Value")
    }

}
