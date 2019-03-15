//
//  MapAnnotationTests.swift
//  BayPassTests
//
//  Created by Tim Roesner on 10/29/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

@testable import BayPass
import CoreLocation
import XCTest

class MapAnnotationTests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDefaultInit() {
        let title = "Lime Scooter"
        let coordinate = CLLocationCoordinate2D(latitude: 34.8, longitude: -121.6)
        let icon = #imageLiteral(resourceName: "MapIcon")
        let color = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        let annotation = MapAnnotation(title: title, coordinate: coordinate, icon: icon, color: color)

        assert(annotation.title == title)
        assert(annotation.coordinate.latitude == coordinate.latitude)
        assert(annotation.coordinate.longitude == coordinate.longitude)
        assert(annotation.icon == icon)
        assert(annotation.color == color)
    }

    func testScooterInit() {
        let icon = #imageLiteral(resourceName: "Scooter")
        let color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        let bird = ScooterCompany(name: "Bird", icon: icon, color: color)
        let location = CLLocation(latitude: 0.0, longitude: 0.0)
        let scooter = Scooter(code: "XAY6HK", location: location, battery: "55%", company: bird)
        let annotation = MapAnnotation(fromScooter: scooter)

        assert(annotation.title == "Bird Scooter")
        assert(annotation.coordinate.latitude == location.coordinate.latitude)
        assert(annotation.coordinate.longitude == location.coordinate.longitude)
        assert(annotation.icon == icon)
        assert(annotation.color == color)
    }

    func testStationInit() {
        let location = CLLocation(latitude: 34.8, longitude: -121.6)
        let station = Station(name: "Mill", code: 3, transitModes: [TransitMode.bus], lines: [Line(name: "name", agency: Agency.BART, destination: "Some", color: #colorLiteral(red: 0.2901960784, green: 0.5647058824, blue: 0.8862745098, alpha: 1), transitMode: TransitMode.bus)], location: location)
        let annotation = MapAnnotation(fromStation: station)

        assert(annotation.title == station.name)
        assert(annotation.coordinate.latitude == location.coordinate.latitude)
        assert(annotation.coordinate.longitude == location.coordinate.longitude)
        assert(annotation.icon == UIImage(named: "Bus"))
        assert(annotation.color == station.color)
    }

    func testBikeDockInit() {
        let location = CLLocation(latitude: 34.8, longitude: -121.6)
        let bikeDock = BikeDock(name: "Ford GoBikes City Hall", location: location, bikesAvailible: 12)
        let annotation = MapAnnotation(fromBikeDock: bikeDock)

        assert(annotation.title == bikeDock.name)
        assert(annotation.coordinate.latitude == location.coordinate.latitude)
        assert(annotation.coordinate.longitude == location.coordinate.longitude)
        assert(annotation.icon == bikeDock.icon)
        assert(annotation.color == bikeDock.color)
    }
}
