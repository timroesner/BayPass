//
//  GoogleMapsTests.swift
//  BayPassTests
//
//  Created by Tim Roesner on 2/17/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

@testable import BayPass
import CoreLocation
import XCTest

class GoogleMapsTests: XCTestCase {
    var testJson: [String: Any] = [:]

    override func setUp() {
        let path = Bundle(for: type(of: self)).path(forResource: "GoogleDirections", ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)
        testJson = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testApi() {
        let expectation = self.expectation(description: "async")
        var result = [Route]()

        let diridonStation = CLLocationCoordinate2D(latitude: 37.3345134, longitude: -121.9064766)
        let santaClaraStation = CLLocationCoordinate2D(latitude: 37.353137, longitude: -121.9389346)

        GoogleMaps().getRoutes(from: diridonStation, to: santaClaraStation, completion: {
            result = $0
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(result.isEmpty, false)
    }

    func testRouteParser() {
        let routes = testJson["routes"] as! [[String: Any]]
        let testRoute = GoogleMaps().parseRoute(from: routes[0])

        XCTAssertEqual(testRoute?.departureTime, Date(timeIntervalSince1970: 1_539_632_611))
        XCTAssertEqual(testRoute?.arrivalTime, Date(timeIntervalSince1970: 1_539_636_989))

        let firstSegment = testRoute?.segments[0]
        XCTAssertEqual(firstSegment?.distanceInMeters, 1149)
        XCTAssertEqual(firstSegment?.durationInMinutes, 14)
        XCTAssertEqual(firstSegment?.travelMode, .walking)
        XCTAssertEqual(firstSegment?.polyline.coordinate.latitude, 37.3456950943918)
        XCTAssertEqual(firstSegment?.polyline.coordinate.longitude, -121.89542)

        let secondSegment = testRoute?.segments[1]
        XCTAssertEqual(secondSegment?.distanceInMeters, 12973)
        XCTAssertEqual(secondSegment?.durationInMinutes, 39)
        XCTAssertEqual(secondSegment?.departureTime, Date(timeIntervalSince1970: 1_539_633_480))
        XCTAssertEqual(secondSegment?.arrivalTime, Date(timeIntervalSince1970: 1_539_635_820))
        XCTAssertEqual(secondSegment?.line?.name, "De Anza Col - Downtown San Jose")
        XCTAssertEqual(secondSegment?.travelMode, .transit)
        XCTAssertEqual(secondSegment?.polyline.coordinate.latitude, 37.332450590606086)
        XCTAssertEqual(secondSegment?.polyline.coordinate.longitude, -121.95055500000004)

        let thirdSegment = testRoute?.segments[2]
        XCTAssertEqual(thirdSegment?.distanceInMeters, 1548)
        XCTAssertEqual(thirdSegment?.durationInMinutes, 19)
        XCTAssertEqual(thirdSegment?.travelMode, .walking)
        XCTAssertEqual(thirdSegment?.polyline.coordinate.latitude, 37.32897023480877)
        XCTAssertEqual(thirdSegment?.polyline.coordinate.longitude, -122.013855)
    }

    func testRouteParserEmptyJson() {
        let testJson: [String: Any] = [:]
        let testRoute = GoogleMaps().parseRoute(from: testJson)
        XCTAssertNil(testRoute)
    }

    func testSegmentParserEmptyJson() {
        let testJson: [String: Any] = [:]
        let testSegment = GoogleMaps().parseSegment(from: testJson)
        XCTAssertNil(testSegment)
    }
}
