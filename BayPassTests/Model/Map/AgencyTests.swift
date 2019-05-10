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
        XCTAssertEqual(Agency.CalTrain.stringValue, "CalTrain")
        XCTAssertEqual(Agency.BART.stringValue, "BART")
        XCTAssertEqual(Agency.VTA.stringValue, "VTA")
        XCTAssertEqual(Agency.Muni.stringValue, "Muni")
        XCTAssertEqual(Agency.ACTransit.stringValue, "AC Transit")
        XCTAssertEqual(Agency.SolTrans.stringValue, "SolTrans")
        XCTAssertEqual(Agency.SamTrans.stringValue, "SamTrans")
        XCTAssertEqual(Agency.ACE.stringValue, "ACE")
        XCTAssertEqual(Agency.GoldenGateTransit.stringValue, "Golden Gate\nTransit")
        XCTAssertEqual(Agency.UnionCity.stringValue, "Union City Transit")
    }

    func testColor() {
        XCTAssertEqual(Agency.CalTrain.getColor(), #colorLiteral(red: 0.8666666667, green: 0.3294117647, blue: 0.2549019608, alpha: 1))
        XCTAssertEqual(Agency.BART.getColor(), #colorLiteral(red: 0.2225468159, green: 0.5167737603, blue: 0.8060272932, alpha: 1))
        XCTAssertEqual(Agency.VTA.getColor(), #colorLiteral(red: 0.2041481137, green: 0.5105623603, blue: 0.7108158469, alpha: 1))
        XCTAssertEqual(Agency.Muni.getColor(), #colorLiteral(red: 0.8471637368, green: 0.2528677583, blue: 0.4470937252, alpha: 1))
        XCTAssertEqual(Agency.ACTransit.getColor(), #colorLiteral(red: 0.2426148951, green: 0.77398628, blue: 0.5919234753, alpha: 1))
        XCTAssertEqual(Agency.SolTrans.getColor(), #colorLiteral(red: 0.9531665444, green: 0.6216368079, blue: 0.2471764088, alpha: 1))
        XCTAssertEqual(Agency.SamTrans.getColor(), #colorLiteral(red: 0.3274793029, green: 0.347738862, blue: 0.8402771354, alpha: 1))
        XCTAssertEqual(Agency.ACE.getColor(), #colorLiteral(red: 0.6209517717, green: 0.3887558877, blue: 0.8284057975, alpha: 1))
        XCTAssertEqual(Agency.GoldenGateTransit.getColor(), #colorLiteral(red: 0.3713163137, green: 0.7446632385, blue: 0.5321159363, alpha: 1))
        XCTAssertEqual(Agency.UnionCity.getColor(), #colorLiteral(red: 0.2191202641, green: 0.5643225312, blue: 0.8827003837, alpha: 1))
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
        let subject = Agency.SamTrans
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
