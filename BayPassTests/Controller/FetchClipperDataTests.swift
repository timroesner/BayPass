//
//  FetchClipperDataTests.swift
//  BayPass
//
//  Created by Tim Roesner on 3/29/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

@testable import BayPass
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
}
