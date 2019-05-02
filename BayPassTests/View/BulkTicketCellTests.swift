//
//  BulkTicketCellTests.swift
//  BayPassTests
//
//  Created by Tim Roesner on 5/2/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

@testable import BayPass
import XCTest
import MapKit

class BulkTicketCellTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCell() {
        let cell = BulkTicketTableViewCell()
        
        let depTime = Date(timeIntervalSinceNow: 60)
        let arrTime = Date(timeIntervalSinceNow: 240)
        let polyline = MKPolyline(coordinates: [])
        let line = Line(name: "522", agency: Agency.ACE, destination: "Palo Alto", color: #colorLiteral(red: 0.2901960784, green: 0.5647058824, blue: 0.8862745098, alpha: 1), transitMode: TransitMode.bus)
        let waypoints = ["firstStop", "secondStop"]
        let segment = RouteSegment(distanceInMeters: 3000, departureTime: depTime, arrivalTime: arrTime, polyline: polyline, travelMode: TravelMode.transit, line: line, price: 2.25, waypoints: waypoints)
        
        cell.setup(with: segment)
        XCTAssertEqual(cell.priceLbl.text, "$2.25")
    }

}
