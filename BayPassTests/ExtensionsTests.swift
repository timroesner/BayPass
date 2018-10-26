//
//  ExtensionsTests.swift
//  BayPassTests
//
//  Created by Tim Roesner on 10/25/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

@testable import BayPass
import XCTest
import MapKit

class ExtensionsTests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUIColorFromHex() {
        let expecetd = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        let hex = UIColor(hex: 0x000000)
        assert(expecetd == hex)
    }
    
    func testUIColorBase255() {
        let expecetd = UIColor(red: 156.0/255.0, green: 0, blue: 1, alpha: 1)
        let base255 = UIColor(red: 156, green: 0, blue: 255)
        assert(expecetd == base255)
    }
    
    func testSafeIndex() {
        let array = ["index 0", "index 1"]
        assert(array[safe: 0] == "index 0")
        assert(array[safe: 2] == nil)
    }
    
    func testLocalizedString() {
        assert("Hello".localized() == "Hello")
    }
    
    func testPolyline() {
        let coordinates = [CLLocationCoordinate2D(latitude: 133.81, longitude: 22.61), CLLocationCoordinate2D(latitude: 122.81, longitude: 36.61)]
        let expected = MKPolyline(coordinates: coordinates, count: coordinates.count)
        let actual = MKPolyline(coordinates: coordinates)
        assert(expected.pointCount == actual.pointCount)
    }
}
