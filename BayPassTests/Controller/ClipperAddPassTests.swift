//
//  ClipperAddPassTests.swift
//  BayPassTests
//
//  Created by Tim Roesner on 4/17/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

@testable import BayPass
import XCTest

class ClipperAddPassTests: XCTestCase {
    let vc = ClipperPassViewController()
    
    override func setUp() {
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRecentlyPurchased() {
        let pass = Pass(name: "Monthly Pass", duration: DateInterval(start: Date(timeIntervalSinceNow: -300), duration: 36000), price: 260.0, validOnAgency: .CalTrain)
        let testCard = ClipperCard(number: 9_999_999_999, cashValue: 0.0, passes: [pass])
        UserManager.shared.setClipperCard(card: testCard)
        UIApplication.shared.keyWindow!.rootViewController = vc
        XCTAssertNotNil(UIApplication.shared.keyWindow?.rootViewController)
    }
    
    func testNewCard() {
        let testCard = ClipperCard(number: 9_999_999_999, cashValue: 0.0, passes: [])
        UserManager.shared.setClipperCard(card: testCard)
        UIApplication.shared.keyWindow!.rootViewController = vc
        XCTAssertNotNil(UIApplication.shared.keyWindow?.rootViewController)
    }

}
