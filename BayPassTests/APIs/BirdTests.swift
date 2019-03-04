//
//  BirdTests.swift
//  BayPassTests
//
//  Created by Tim Roesner on 12/2/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

@testable import BayPass
import XCTest
import CoreLocation

class BirdTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testParser() {
        let birdCompany = Bird().birdCompany
        let location = CLLocation(latitude: 32.6, longitude: -121.5)
        let testScooter = Scooter(code: "XFGHJ", location: location, battery: "69", company: birdCompany)
        
        let testJson: [String:Any] = [
            "id": "ae2ad5f7-29ee-422f-93ab-12978d6c7ea4",
            "location":
            [
                "latitude": 32.6,
                "longitude": -121.5
            ],
            "battery_level": 69,
            "captive": 0,
            "code": "XFGHJ"
        ]
        let actualScooter = Bird().parseJson(json: testJson)
        assert(actualScooter.code == testScooter.code)
        assert(actualScooter.battery == testScooter.battery)
        assert(actualScooter.location.coordinate.latitude == testScooter.location.coordinate.latitude)
        assert(actualScooter.location.coordinate.longitude == testScooter.location.coordinate.longitude)
        assert(actualScooter.company == testScooter.company)
    }
    
    func testParserEmpty() {
        let birdCompany = Bird().birdCompany
        let location = CLLocation(latitude: 0.0, longitude: 0.0)
        let testScooter = Scooter(code: "", location: location, battery: "0", company: birdCompany)
        
        let testJson: [String:Any] = [:]
        let actualScooter = Bird().parseJson(json: testJson)
        
        assert(actualScooter.code == testScooter.code)
        assert(actualScooter.battery == testScooter.battery)
        assert(actualScooter.location.coordinate.latitude == testScooter.location.coordinate.latitude)
        assert(actualScooter.location.coordinate.longitude == testScooter.location.coordinate.longitude)
        assert(actualScooter.company == testScooter.company)
    }
    
    func testGetScooters() {
        let expectation = self.expectation(description: "async")
        var scooters = [Scooter]()
        
        let now = Date()
        let ninePM = Calendar(identifier: .gregorian).date(bySettingHour: 21, minute: 0, second: 0, of: now)!
        let sevenAM = Calendar(identifier: .gregorian).date(bySettingHour: 7, minute: 0, second: 0, of: now)!
        
        var location = CLLocation(latitude: 48.865314, longitude: 2.343086)
        
        // If bird shutdown in SJ use Paris
        if sevenAM < now && now < ninePM {
            location = CLLocation(latitude: 37.331348, longitude: -121.888877)
        }
        
        Bird().getScooters(fromLocation: location, radius: 1000, completion: {
            scooters = $0
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
        assert(!scooters.isEmpty)
    }

}
