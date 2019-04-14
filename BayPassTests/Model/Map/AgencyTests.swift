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

    func testStringValue() {
        XCTAssertEqual(Agency.CalTrain.stringValue, "CalTrain")
        XCTAssertEqual(Agency.BART.stringValue, "BART")
        XCTAssertEqual(Agency.VTA.stringValue, "VTA")
        XCTAssertEqual(Agency.Muni.stringValue, "Muni")
        XCTAssertEqual(Agency.ACTransit.stringValue, "AC Transit")
        XCTAssertEqual(Agency.SolTrans.stringValue, "SolTrans")
        XCTAssertEqual(Agency.SamTrans.stringValue, "SamTrans")
        XCTAssertEqual(Agency.ACE.stringValue, "ACE")
        XCTAssertEqual(Agency.GoldenGateTransit.stringValue, "Golden Gate Transit")
        XCTAssertEqual(Agency.UnionCity.stringValue, "Union City Transit")
    }
    
    func test_Agency_BuildsThePath() {
        let subject = Agency(rawValue: "BAR")
        XCTAssertEqual(subject, Agency.BART)
    }
    
    func testGetIconACE() {
        let subject = Agency.ACE
        XCTAssertEqual(subject.getIcon(), #imageLiteral(resourceName: "CalTrain"))
    }
    
    func testGetIconACTransit() {
        let subject = Agency.ACTransit
        XCTAssertEqual(subject.getIcon(), #imageLiteral(resourceName: "Bus"))
    }
    
    func testGetIconBART() {
        let subject = Agency.BART
        XCTAssertEqual(subject.getIcon(), #imageLiteral(resourceName: "BART"))
    }
    
    func testGetIconCalTrain() {
        let subject = Agency.CalTrain
        XCTAssertEqual(subject.getIcon(), #imageLiteral(resourceName: "CalTrain"))
    }
    
    func testGetIconGoldenGateTransit() {
        let subject = Agency.GoldenGateTransit
        XCTAssertEqual(subject.getIcon(), #imageLiteral(resourceName: "Bus"))
    }
    
    func testGetIconMuni() {
        let subject = Agency.Muni
        XCTAssertEqual(subject.getIcon(), #imageLiteral(resourceName: "Bus"))
    }
    
    func testGetIconUnionCity() {
        let subject = Agency.UnionCity
        XCTAssertEqual(subject.getIcon(), #imageLiteral(resourceName: "Bus"))
    }
    
    func testGetIconSamsTrans() {
        let subject = Agency.SamTrans
        XCTAssertEqual(subject.getIcon(), #imageLiteral(resourceName: "Bus"))
    }
    
    func testGetIconSolTrans() {
        let subject = Agency.SolTrans
        XCTAssertEqual(subject.getIcon(), #imageLiteral(resourceName: "Bus"))
    }
}
