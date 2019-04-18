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
    
    let mapVC = MapViewController()

    override func setUp() {
        UIApplication.shared.keyWindow!.rootViewController = mapVC
        XCTAssertNotNil(UIApplication.shared.keyWindow?.rootViewController)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSetup() {
        let mockLocationManager = MockLocationManager()
        mockLocationManager.mockLocation = CLLocation(latitude: 37.331348, longitude: -121.888877)
        mapVC.locationManager = mockLocationManager
        mapVC.centerOnUserLocation()
        XCTAssertEqual(mockLocationManager.mockLocation?.coordinate.latitude, mapVC.locationManager.location?.coordinate.latitude)
        XCTAssertEqual(mockLocationManager.mockLocation?.coordinate.longitude, mapVC.locationManager.location?.coordinate.longitude)
    }
    
    func testEmptyRoutes() {
        mapVC.setupRoutesView(with: [])
    }
    
    func testStationOverview() {
        let station = Station(name: "Diridon", code: 22, transitModes: [.calTrain, .bus,. lightRail], lines: [], location: CLLocation(latitude: 34.3, longitude: -121.4))
        mapVC.displayStationInfo(to: station)
        XCTAssertEqual(mapVC.mapView.annotations.count, 1)
    }
    
    func testTapRouteOverView() {
        let routeView = RouteOverView(with: Route(departureTime: Date(timeIntervalSinceNow: 60), arrivalTime: Date(timeIntervalSinceNow: 360), segments: []))
        let tapRecognizer = UITapGestureRecognizer()
        routeView.addGestureRecognizer(tapRecognizer)
        mapVC.tapRoute(tapRecognizer)
        XCTAssertFalse(routeView.gestureRecognizers!.isEmpty)
    }

}
