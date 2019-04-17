//
//  ProgressHUDTests.swift
//  BayPassTests
//
//  Created by Tim Roesner on 4/2/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

@testable import BayPass
import XCTest

class ProgressHUDTests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testProgressHUD() {
        let vc = UIViewController()
        let progressHUD = ProgressHUD()
        vc.view.addSubview(progressHUD)
        progressHUD.stop()
        XCTAssertNotNil(progressHUD)
    }
}
