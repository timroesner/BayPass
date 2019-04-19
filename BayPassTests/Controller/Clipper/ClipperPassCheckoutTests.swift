//
//  ClipperPassCheckoutTests.swift
//  BayPassTests
//
//  Created by Tim Roesner on 4/17/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

@testable import BayPass
import XCTest

class ClipperPassCheckoutTests: XCTestCase {
     let vc = ClipperPassCheckoutViewController()

    override func setUp() {
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSetup() {
        vc.agency = .BART
        UIApplication.shared.keyWindow!.rootViewController = vc
        XCTAssertNotNil(UIApplication.shared.keyWindow?.rootViewController)
    }
    
    func testPayButton() {
        vc.pay()
    }

}
