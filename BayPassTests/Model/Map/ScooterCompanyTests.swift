//
//  ScooterCompanyTests.swift
//  BayPassTests
//
//  Created by Ayesha Khan on 10/27/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

@testable import BayPass
import XCTest

class ScooterCompanyTests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_ScooterCompany_BuildsThePath() {
        let name: String = "Test"
        let subject = ScooterCompany(name: name)
        
        XCTAssertEqual(subject.name, "Test")
    }
}
