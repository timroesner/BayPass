//
//  PassTests.swift
//  BayPassTests
//
//  Created by Ayesha Khan on 10/28/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

@testable import BayPass
import CoreLocation
import XCTest

class PassTests: XCTestCase {
    
    var agency: Agency?
    
    override func setUp() {
        let loc: CLLocation = CLLocation(latitude: 21.35, longitude: 121.34)
        let station = Station(name: "SFO", code: 2, transitModes: [TransitMode.bart], lines: ["Green"], location: loc)
        let line = Line(name: "Green", code: 2, destination: "Milbrae", stops: [station])
        agency = Agency(rawValue: "BART")
    }

    override func tearDown() {
        agency = nil
    }
    
    func test_Pass_BuildsThePath() {
        let name = "some"
        let dur = DateInterval()
        let cost = 2.3
        let testPass = Pass(name: name, duration: dur, price: cost, validOnAgency: agency!)
        
        XCTAssertEqual(testPass.name, "some")
        XCTAssertEqual(testPass.duration, dur)
        XCTAssertEqual(testPass.price, 2.3)
    }
    
    func testIsValidTrue() {
        let duration = DateInterval(start: Date(), duration: 60)
        let testPass = Pass(name: "BART", duration: duration, price: 12.35, validOnAgency: agency!)
        assert(testPass.isValid())
    }
    
    func testIsValidFalse() {
        let duration = DateInterval(start: Date(timeIntervalSince1970: 60), duration: 45)
        let testPass = Pass(name: "BART", duration: duration, price: 12.35, validOnAgency: agency!)
        assert(testPass.isValid() == false)
    }
}
