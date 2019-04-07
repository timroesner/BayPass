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
        let subject = Agency(rawValue: "BAR")

        XCTAssertEqual(subject, Agency.BART)
    }

    func testStringValue() {
        let subject = Agency.ACTransit

        XCTAssertEqual(subject.stringValue, "AC Transit")
    }

    func testStringValueMuni() {
        let subject = Agency.Muni
        XCTAssertEqual(subject.stringValue, "Muni")
    }

    func testStringValueUnionCity() {
        let subject = Agency.UnionCity
        XCTAssertEqual(subject.stringValue, "Union City Transit")
    }

    func testStringValueSamsTrans() {
        let subject = Agency.SamsTrans
        XCTAssertEqual(subject.stringValue, "SamsTrans")
    }

    func testStringValueSolsTrans() {
        let subject = Agency.SolTrans
        XCTAssertEqual(subject.stringValue, "SolsTrans")
    }

    func testGetIconACE() {
        let subject = Agency.ACE
        XCTAssertEqual(subject.getIcon(), #imageLiteral(resourceName: "CalTrain"))
    }

    func testGetIconACTransit() {
        let subject = Agency.ACTransit
        XCTAssertEqual(subject.getIcon(), #imageLiteral(resourceName: "Bus"))
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
        let subject = Agency.SamsTrans
        XCTAssertEqual(subject.getIcon(), #imageLiteral(resourceName: "Bus"))
    }

    func testGetIconSolTrans() {
        let subject = Agency.SolTrans
        XCTAssertEqual(subject.getIcon(), #imageLiteral(resourceName: "Bus"))
    }

    func testGetIconDefault() {
        let subject = Agency.zero
        XCTAssertEqual(subject.getIcon(), #imageLiteral(resourceName: "CalTrain"))
    }
}
