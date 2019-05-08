//
//  ClipperPassCheckoutTests.swift
//  BayPassTests
//
//  Created by Tim Roesner on 4/17/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

@testable import BayPass
import XCTest
import Stripe

class ClipperPassCheckoutTests: XCTestCase {
     let vc = ClipperPassCheckoutViewController()

    override func setUp() {
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSetup() {
        vc.agency = .BART
        UIApplication.shared.keyWindow!.rootViewController = vc
        XCTAssertNotNil(UIApplication.shared.keyWindow?.rootViewController)
    }
    
    func testPayButton() {
        vc.currentPassPrice = 5.00
        vc.pay()
    }
    
    func testDidFinish() {
        let request = Stripe.paymentRequest(withMerchantIdentifier: Credentials().merchantId, country: "US", currency: "USD")
        request.paymentSummaryItems = [PKPaymentSummaryItem(label: "TestItem", amount: NSDecimalNumber(value: 5.00))]
        let paymentVC = PKPaymentAuthorizationViewController(paymentRequest: request)!
        vc.paymentAuthorizationViewControllerDidFinish(paymentVC)
        
        let presentedVC = UIApplication.shared.keyWindow?.rootViewController?.presentedViewController
        XCTAssertFalse(presentedVC is ClipperPassCheckoutViewController)
    }
    
    func testDidAuthorize() {
        let request = Stripe.paymentRequest(withMerchantIdentifier: Credentials().merchantId, country: "US", currency: "USD")
        request.paymentSummaryItems = [PKPaymentSummaryItem(label: "TestItem", amount: NSDecimalNumber(value: 5.00))]
        let paymentVC = PKPaymentAuthorizationViewController(paymentRequest: request)!
        let payment = PKPayment()
        
        let expectation = self.expectation(description: "async")
        var statusResult = PKPaymentAuthorizationStatus(rawValue: 0)
        vc.paymentAuthorizationViewController(paymentVC, didAuthorizePayment: payment) {
            statusResult = $0
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        print(statusResult as Any)
    }

}
