//
//  PurchesedTicketCellTests.swift
//  BayPassTests
//
//  Created by Zhe Li on 2/27/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

@testable import BayPass
import XCTest
import SnapKit
import CoreLocation

class PurchesedTicketCellTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSetup() {
        let loc: CLLocation = CLLocation(latitude: 21.35, longitude: 121.34)
        let station = Station(name: "SFO", code: 2, transitModes: [TransitMode.bart], lines: ["Green"], location: loc)
        let line = Line(name: "Green", code: 2, destination: "Milbrae", stops: [station])
        let duration = DateInterval(start: Date(timeIntervalSince1970: 60), duration: 45)
        let bart = Agency(name: "BART", routes: [line])
        let pass = Pass(name: "Monthly Pass", duration: duration, price: 12.25, validOnAgency: bart)
        
        let cell = PurchesedTicketCell()
        cell.setup(with: pass, agency: "BART", icon: UIImage(named: "CalTrain")!)
        
        XCTAssertEqual(cell.nameLbl.text, "Monthly Pass")
        XCTAssertEqual(cell.durationLbl.text, "Valid until 12/31/69")
    }
    
    
    
}
