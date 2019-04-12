//
//  AgencyTests.swift
//  BayPassTests
//
//  Created by Ayesha Khan on 10/28/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

@testable import BayPass
import CoreLocation
import XCTest

class AgencyTests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testStringValue() {
        XCTAssertEqual(Agency.CalTrain.stringValue, "CalTrain")
        XCTAssertEqual(Agency.BART.stringValue, "BART")
        XCTAssertEqual(Agency.VTA.stringValue, "VTA")
        XCTAssertEqual(Agency.Muni.stringValue, "Muni")
        XCTAssertEqual(Agency.ACTransit.stringValue, "AC Transit")
        XCTAssertEqual(Agency.SolTrans.stringValue, "SolTrans")
        XCTAssertEqual(Agency.SamTrans.stringValue, "SamTrans")
        XCTAssertEqual(Agency.ACE.stringValue, "ACE")
        XCTAssertEqual(Agency.GoldenGateTransit.stringValue, "Golden Gate Transit")
        XCTAssertEqual(Agency.UnionCity.stringValue, "Union City Transit")
    }
}
