//
//  ClipperPassCellTests.swift
//  BayPassTests
//
//  Created by Tim Roesner on 4/2/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

@testable import BayPass
import XCTest

class ClipperPassCellTests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSetupAdd() {
        let cell = ClipperPassCollectionViewCell()
        cell.setupAdd()
        XCTAssertNotNil(cell)
    }

    func testSetupWithPass() {
        let pass = Pass(name: "monthly", duration: DateInterval(start: Date(), duration: 3600), price: 45.0, validOnAgency: Agency(name: "CalTrain", routes: [], icon: #imageLiteral(resourceName: "CalTrain")))
        let cell = ClipperPassCollectionViewCell()
        cell.setup(with: pass)
        XCTAssertNotNil(cell)
    }
}
