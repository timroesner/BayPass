//
//  StationPinTests.swift
//  BayPassTests
//
//  Created by Ayesha Khan on 4/5/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

@testable import BayPass
import MapKit
import XCTest

class StationPinTests: XCTest {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_StationPin_BuildsThePath() {
        let location = CLLocationCoordinate2D(latitude: 34.5, longitude: -123)
        let subject = StationPin(title: "test", imageName: #imageLiteral(resourceName: "MapIcon"), coordinate: location)

        XCTAssertEqual(subject.title, "test")
        XCTAssertEqual(subject.imageName, #imageLiteral(resourceName: "MapIcon"))
        XCTAssertEqual(subject.coordinate.latitude, location.latitude)
        XCTAssertEqual(subject.coordinate.longitude, location.longitude)
    }
}
