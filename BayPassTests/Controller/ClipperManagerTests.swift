//
//  ClipperManagerTests.swift
//  BayPassTests
//
//  Created by Tim Roesner on 4/6/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

@testable import BayPass
import XCTest

class ClipperManagerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFlow() {
        let card = ClipperCard(number: 1111111111, cashValue: 5.00, passes: [])
        ClipperManager.shared.setClipperCard(card: card)
        XCTAssertEqual(ClipperManager.shared.getClipperCard()?.cashValue, 5.00)
        
        ClipperManager.shared.addCashToCard(amount: 4.00)
        XCTAssertEqual(ClipperManager.shared.getClipperCard()?.cashValue, 9.00)
        
        ClipperManager.shared.removeCard()
        XCTAssertNil(ClipperManager.shared.getClipperCard())
    }

}
