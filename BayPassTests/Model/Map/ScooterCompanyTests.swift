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
        let name = "Bird"
        let icon = #imageLiteral(resourceName: "MapIcon")
        let color = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        let company = ScooterCompany(name: name, icon: icon, color: color)
        
        assert(company.name == name)
        assert(company.icon == icon)
        assert(company.color == color)
    }
}
