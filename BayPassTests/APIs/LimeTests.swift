//
//  LimeTests.swift
//  BayPassTests
//
//  Created by Tim Roesner on 3/14/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import Foundation

@testable import BayPass
import XCTest
import CoreLocation

class LimeTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testParser() {
        let birdCompany = Lime().limeCompany
        let location = CLLocation(latitude: 37.33112333333334, longitude: -121.88821333333333)
        let testScooter = Scooter(code: "", location: location, battery: "", company: birdCompany)
        
        let testJson: [String:Any] = [
            "type": "SCOOTER",
            "lat": 37.33112333333334,
            "lng": -121.88821333333333
        ]
        let actualScooter = Lime().parseJson(json: testJson)
        XCTAssertEqual(actualScooter!.code, testScooter.code)
        XCTAssertEqual(actualScooter!.battery, testScooter.battery)
        XCTAssertEqual(actualScooter!.location.coordinate.latitude, testScooter.location.coordinate.latitude)
        XCTAssertEqual(actualScooter!.location.coordinate.longitude, testScooter.location.coordinate.longitude)
        XCTAssertEqual(actualScooter!.company, testScooter.company)
    }
    
    func testParserEmpty() {
        let testJson: [String:Any] = [:]
        let actualScooter = Lime().parseJson(json: testJson)
        
        XCTAssertNil(actualScooter)
    }
    
    func testGetScooters() {
        let expectation = self.expectation(description: "async")
        var scooters = [Scooter]()
        
        let location = CLLocationCoordinate2D(latitude: 37.331348, longitude: -121.888877)
        
        Lime().getScooters(fromLocation: location, completion: {
            scooters = $0
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(!scooters.isEmpty)
    }
    
}
