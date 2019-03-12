//
//  StationSearchResultTableViewCellTests.swift
//  BayPassTests
//
//  Created by Tim Roesner on 2/27/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

@testable import BayPass
import XCTest
import CoreLocation

class StationSearchResultTableViewCellTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSetupDiridon() {
        let cell = StationSearchResultTableViewCell()
<<<<<<< HEAD
        let station = Station(name: "San Jose Diridon", code: 112, transitModes: [.bus, .lightRail, .calTrain], lines: ["Cal", "922", "923", "17", "64"], location: CLLocation(latitude: 0.0, longitude: 0.0))
=======
        let line1 = Line(name: "Cal", agency: Agency.VTA, destination: "somewhere", color: #colorLiteral(red: 0.2901960784, green: 0.5647058824, blue: 0.8862745098, alpha: 1), transitMode: TransitMode.bus)
        let line2 = Line(name: "Cal", agency: Agency.Muni, destination: "somewhere", color: #colorLiteral(red: 0.2901960784, green: 0.5647058824, blue: 0.8862745098, alpha: 1), transitMode: TransitMode.lightRail)
        let line3 = Line(name: "Cal", agency: Agency.CalTrain, destination: "somewhere", color: #colorLiteral(red: 0.2901960784, green: 0.5647058824, blue: 0.8862745098, alpha: 1), transitMode: TransitMode.calTrain)
        let station = Station(name: "San Jose Diridon", code: 112, transitModes: [.bus, .lightRail, .calTrain], lines: [line1, line2, line3], location: CLLocation(latitude: 0.0, longitude: 0.0))
>>>>>>> changes for agency
        cell.setup(with: station)
        
        XCTAssertEqual(cell.title.text, "San Jose Diridon")
        XCTAssertEqual(cell.iconView.image, UIImage(named: "CalTrain"))
        XCTAssertEqual(cell.lineView.subviews.count, 3)
    }
    
    func testSetupSanFernando() {
        let cell = StationSearchResultTableViewCell()
        let station = Station(name: "7th & San Fernando", code: 922, transitModes: [.bus], lines: ["64", "72", "73", "81"], location: CLLocation(latitude: 0.0, longitude: 0.0))
        cell.setup(with: station)
        
        XCTAssertEqual(cell.title.text, "7th & San Fernando")
        XCTAssertEqual(cell.iconView.image, UIImage(named: "Bus"))
        XCTAssertEqual(cell.lineView.subviews.count, 4)
    }

}
