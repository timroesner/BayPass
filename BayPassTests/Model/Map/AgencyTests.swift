//
//  AgencyTests.swift
//  BayPassTests
//
//  Created by Ayesha Khan on 10/28/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

@testable import BayPass
import CoreLocation
import XCTest

class AgencyTests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_Agency_BuildsThePath() {
        let name = "Test"
<<<<<<< HEAD
        let loc: CLLocation = CLLocation(latitude: 0.0, longitude: 0.0)
        let routesT = [Line(name: "ran", code: 2, destination: "dest", stops: [Station(name: "ran", code: 3, transitModes: [TransitMode.bart], lines: ["line"], location: loc)])]
        
        let subject = Agency(name: name, routes: routesT, icon: UIImage(named: "CalTrain")!)
        
        XCTAssertEqual(subject.name, name)
        assert(subject.getRoutes() == routesT)
=======
        let subject = Agency(rawValue: "BA")

        XCTAssertEqual(subject?.rawValue, Agency.BART.rawValue)
>>>>>>> some api fixes and test fixes
    }
}
