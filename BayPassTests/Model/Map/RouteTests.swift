//
//  RoutesTests.swift
//  BayPassTests
//
//  Created by Ayesha Khan on 10/28/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

@testable import BayPass
import XCTest
import MapKit

class RouteTests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testRouteInit() {
        let depTime = Date(timeIntervalSinceNow: 60)
        let arrTime = Date(timeIntervalSinceNow: 240)
        let polyline = MKPolyline(coordinates: [])
        let firstSegment = RouteSegment(distanceInMeters: 500, durationInMinutes: 22, polyline: polyline, travelMode: .walking)
        let segments = [firstSegment]
        let route = Route(departureTime: depTime, arrivalTime: arrTime, segments: segments)
        
        assert(route.departureTime == depTime)
        assert(route.arrivalTime == arrTime)
        assert(route.segments == segments)
    }
    
    func testEmptyBoundingRect() {
        let depTime = Date(timeIntervalSinceNow: 60)
        let arrTime = Date(timeIntervalSinceNow: 240)
        let testRoute = Route(departureTime: depTime, arrivalTime: arrTime, segments: [])
        XCTAssertNil(testRoute.getBoundingMapRect())
    }
}
