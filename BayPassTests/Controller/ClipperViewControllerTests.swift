//
//  ClipperViewControllerTests.swift
//  BayPass
//
//  Created by Tim Roesner on 4/1/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

@testable import BayPass
import XCTest

class ClipperViewControllerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        let calTrain = Agency(name: "CalTrain", routes: [], icon: #imageLiteral(resourceName: "CalTrain"))
        let testCard = ClipperCard(number: 9999999999, cashValue: 0.0, passes: [Pass(name: "Monthly", duration: DateInterval(start: Date(), duration: 36000), price: 45.0, validOnAgency: calTrain)])
        clipperManager.setClipperCard(card: testCard)
        let vc = ClipperViewController()
        vc.setupRegularView()
        XCTAssertNotNil(vc)
    }

}
