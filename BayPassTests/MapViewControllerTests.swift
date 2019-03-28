//
//  LocationManagerTests.swift
//  BayPassTests
//
//  Created by Tim Roesner on 3/12/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

@testable import BayPass
import XCTest
import CoreLocation

fileprivate class MockLocationManager : CLLocationManager {
    var mockLocation: CLLocation?
    override var location: CLLocation? {
        return mockLocation
    }
    override init() {
        super.init()
    }
}

class MapViewControllerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        let mapVC = MapViewController()
        let mockLocationManager = MockLocationManager()
        mockLocationManager.mockLocation = CLLocation(latitude: 37.331348, longitude: -121.888877)
        mapVC.locationManager = mockLocationManager
        mapVC.centerOnUserLocation()
        XCTAssertEqual(mockLocationManager.mockLocation?.coordinate.latitude, mapVC.locationManager.location?.coordinate.latitude)
        XCTAssertEqual(mockLocationManager.mockLocation?.coordinate.longitude, mapVC.locationManager.location?.coordinate.longitude)
    }
    
    func testEmptyRoutes() {
        let mapVC = MapViewController()
        mapVC.setupRoutesView(with: [])
    }

}
