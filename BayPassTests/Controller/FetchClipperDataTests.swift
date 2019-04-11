//
//  FetchClipperDataTests.swift
//  BayPass
//
//  Created by Tim Roesner on 3/29/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

@testable import BayPass
import SwiftSoup
import XCTest

class FetchClipperDataTests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchData() {
        let vc = SignInViewController()

        let expectation = self.expectation(description: "async")
        var result: ClipperCard?
        vc.fetchClipperData(email: "tim.roesner@sjsu.edu", password: "abc", completion: {
            result = $0?.first
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(result)
    }

    func testParse() {
        let htmlString = """
            <div class="greyBox2">
                <div class="infoDiv" tabindex="0">
                    <div class="fieldName">Serial Number:</div>
                    <div class="fieldData field90">1232326817</div>
                </div>
                <div class="infoDiv" tabindex="0">
                    <div class="fieldName">Type:</div>
                    <div class="fieldData">ADULT</div>
                </div>
                <div class="infoDiv" tabindex="0">
                    <div class="fieldName">Status:</div>
                    <div class="fieldData">Active</div>
                </div>
                <div class="spacer"></div>
                <div class="infoDiv" tabindex="0">
                    <div class="fieldHeader">
                        <strong>Products on Card:</strong>
                    </div>
                </div>
                <div class="infoDiv" tabindex="0">
                    <div class="fieldName">Cash value:</div>
                    <div class="fieldData" style="width: auto;">$7.20</div>
                </div>
            <div/>
        """
        let doc: Document = try! SwiftSoup.parse(htmlString)
        let vc = SignInViewController()
        let card = vc.parseCard(from: doc)?.first
        XCTAssertEqual(card?.number, 1_232_326_817)
        XCTAssertEqual(card?.cashValue, 7.20)
        XCTAssertEqual(card?.passes.count, 0)
    }
}
