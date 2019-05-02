//
//  RouteDetailsViewControllerTests.swift
//  BayPassTests
//
//  Created by Tim Roesner on 4/17/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

@testable import BayPass
import XCTest
import MapKit

class RouteDetailsViewControllerTests: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSetupSingleTransit() {
        let segmentWalking = RouteSegment(distanceInMeters: 500, durationInMinutes: 22, polyline: MKPolyline(), travelMode: .walking)
        let line = Line(name: "522", agency: Agency.ACE, destination: "Palo Alto", color: #colorLiteral(red: 0.2901960784, green: 0.5647058824, blue: 0.8862745098, alpha: 1), transitMode: TransitMode.bus)
        let waypoints = ["firstStop", "secondStop"]
        let depTime = Date(timeIntervalSinceNow: 60)
        let arrTime = Date(timeIntervalSinceNow: 240)
        let segmentTransit = RouteSegment(distanceInMeters: 3000, departureTime: depTime, arrivalTime: arrTime, polyline: MKPolyline(), travelMode: TravelMode.transit, line: line, price: 2.25, waypoints: waypoints)
        let route = Route(departureTime: depTime, arrivalTime: arrTime, segments: [segmentWalking, segmentTransit])
        
        let vc = RouteDetailsViewController()
        vc.route = route
        vc.routeOverView = RouteOverView(with: route)
        UIApplication.shared.keyWindow!.rootViewController = vc
        XCTAssertNotNil(UIApplication.shared.keyWindow?.rootViewController)
    }
    
    func testSetupDoubleTransit() {
        let line = Line(name: "522", agency: Agency.ACE, destination: "Palo Alto", color: #colorLiteral(red: 0.2901960784, green: 0.5647058824, blue: 0.8862745098, alpha: 1), transitMode: TransitMode.bus)
        let waypoints = ["firstStop", "secondStop"]
        let depTime = Date(timeIntervalSinceNow: 60)
        let arrTime = Date(timeIntervalSinceNow: 240)
        let segmentTransit = RouteSegment(distanceInMeters: 3000, departureTime: depTime, arrivalTime: arrTime, polyline: MKPolyline(), travelMode: TravelMode.transit, line: line, price: 2.25, waypoints: waypoints)
        let route = Route(departureTime: depTime, arrivalTime: arrTime, segments: [segmentTransit, segmentTransit])
        
        let vc = RouteDetailsViewController()
        vc.route = route
        vc.routeOverView = RouteOverView(with: route)
        UIApplication.shared.keyWindow!.rootViewController = vc
        XCTAssertNotNil(UIApplication.shared.keyWindow?.rootViewController)
    }
    
    func testSetupScooterBike() {
        let depTime = Date(timeIntervalSinceNow: 60)
        let arrTime = Date(timeIntervalSinceNow: 240)
        let segmentScooter = RouteSegment(distanceInMeters: 800, durationInMinutes: 22, polyline: MKPolyline(), travelMode: .scooter)
        let segmentBike = RouteSegment(distanceInMeters: 10000, durationInMinutes: 50, polyline: MKPolyline(), travelMode: .bike)
        let route = Route(departureTime: depTime, arrivalTime: arrTime, segments: [segmentScooter, segmentBike])
        
        let vc = RouteDetailsViewController()
        vc.route = route
        vc.routeOverView = RouteOverView(with: route)
        UIApplication.shared.keyWindow!.rootViewController = vc
        XCTAssertNotNil(UIApplication.shared.keyWindow?.rootViewController)
    }
    
    func testBuyTickets() {
        let depTime = Date(timeIntervalSinceNow: 60)
        let arrTime = Date(timeIntervalSinceNow: 240)
        let segmentScooter = RouteSegment(distanceInMeters: 800, durationInMinutes: 22, polyline: MKPolyline(), travelMode: .scooter)
        let segmentBike = RouteSegment(distanceInMeters: 10000, durationInMinutes: 50, polyline: MKPolyline(), travelMode: .bike)
        let route = Route(departureTime: depTime, arrivalTime: arrTime, segments: [segmentScooter, segmentBike])
        
        let vc = RouteDetailsViewController()
        vc.route = route
        vc.routeOverView = RouteOverView(with: route)
        vc.buyTapped()
    }

}
