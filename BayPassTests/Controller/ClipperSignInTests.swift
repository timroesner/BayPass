//
//  ClipperSignInTests.swift
//  BayPassTests
//
//  Created by Tim Roesner on 4/2/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

@testable import BayPass
import XCTest
import SkyFloatingLabelTextField
import SafariServices

class ClipperSignInTests: XCTestCase {
    
    let vc = SignInViewController()

    override func setUp() {
        UIApplication.shared.keyWindow!.rootViewController = vc
        XCTAssertNotNil(UIApplication.shared.keyWindow?.rootViewController)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testChangeText() {
        vc.emailTextField.text = "invalidemail "
        vc.validateEmail(vc.emailTextField)
        
        let textField = vc.emailTextField as? SkyFloatingLabelTextField
        XCTAssertEqual(textField?.errorMessage, "Invalid email")
        XCTAssertEqual(vc.emailTextField.text, "invalidemail")
        XCTAssertTrue(vc.passwordTextField.isEditing)
    }
    
    func testForgotPasswordButton() {
        vc.forgotPassword()
        let presentedVC = UIApplication.shared.keyWindow?.rootViewController?.presentedViewController
        XCTAssert(presentedVC is SFSafariViewController)
    }
    
    func testLoginEmpty() {
        vc.logIn()
        let presentedVC = UIApplication.shared.keyWindow?.rootViewController?.presentedViewController
        XCTAssert(presentedVC is UIAlertController)
    }

    func testLoginWrongPassword() {
        vc.emailTextField.text = "test@gmail.com"
        vc.passwordTextField.text = "abc"
        vc.validateEmail(vc.emailTextField)
        vc.logIn()
    }
}
