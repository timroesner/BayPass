//
//  ClipperAddCashTests.swift
//  BayPassTests
//
//  Created by Tim Roesner on 4/2/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

@testable import BayPass
import XCTest
import Stripe

class ClipperAddCashTests: XCTestCase {
    
    let vc = ClipperAddCashViewController()

    override func setUp() {
        let testCard = ClipperCard(number: 9999999999, cashValue: 0.0, passes: [])
        UserManager.shared.setClipperCard(card: testCard)
        UIApplication.shared.keyWindow!.rootViewController = vc
        XCTAssertNotNil(UIApplication.shared.keyWindow?.rootViewController)
    }

    override func tearDown() {
        UserManager.shared.removeCard()
    }
    
    func testNoCard() {
        UserManager.shared.removeCard()
        vc.setupView()
        let presentedVC = UIApplication.shared.keyWindow?.rootViewController?.presentedViewController
        XCTAssert(presentedVC is UIAlertController)
    }

    func testTitle() {
        XCTAssertEqual(vc.title, "Add Cash Value")
    }
    
    func testTextInput() {
        vc.valueTextField.becomeFirstResponder()
        vc.valueTextField.text = "0.0"
        vc.handleValueInput(vc.valueTextField)
        vc.valueTextField.text = "301"
        vc.handleValueInput(vc.valueTextField)
        vc.valueTextField.text = "$"
        vc.handleValueInput(vc.valueTextField)
        vc.valueTextField.text = "25.00"
        vc.handleValueInput(vc.valueTextField)
        vc.valueTextField.dismiss()
        XCTAssert(vc.value == 25.00)
    }
    
    func testApplePayButton() {
        vc.valueTextField.text = "25.00"
        vc.handleValueInput(vc.valueTextField)
        vc.pay()
        let presentedVC = UIApplication.shared.keyWindow?.rootViewController?.presentedViewController
        XCTAssert(presentedVC is PKPaymentAuthorizationViewController)
    }
    
    func testCreditDebitPayButton() {
        vc.dropDown.tableView.delegate?.tableView?(vc.dropDown.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(PaymentMethod(rawValue: vc.dropDown.getSelectedItem()), PaymentMethod.creditDebit)
        vc.valueTextField.text = "25.00"
        vc.handleValueInput(vc.valueTextField)
        vc.pay()
    }
    
    func testInvalidPay() {
        vc.valueTextField.text = "301"
        vc.handleValueInput(vc.valueTextField)
        vc.pay()
        let presentedVC = UIApplication.shared.keyWindow?.rootViewController?.presentedViewController
        XCTAssert(presentedVC is UIAlertController)
    }
    
    func testDidFinish() {
        let request = Stripe.paymentRequest(withMerchantIdentifier: Credentials().merchantId, country: "US", currency: "USD")
        request.paymentSummaryItems = [PKPaymentSummaryItem(label: "TestItem", amount: NSDecimalNumber(value: 5.00))]
        let paymentVC = PKPaymentAuthorizationViewController(paymentRequest: request)!
        vc.paymentAuthorizationViewControllerDidFinish(paymentVC)
        
        let presentedVC = UIApplication.shared.keyWindow?.rootViewController?.presentedViewController
        XCTAssertFalse(presentedVC is ClipperAddCashViewController)
    }
    
    func testDidAuthorize() {
        let request = Stripe.paymentRequest(withMerchantIdentifier: Credentials().merchantId, country: "US", currency: "USD")
        request.paymentSummaryItems = [PKPaymentSummaryItem(label: "TestItem", amount: NSDecimalNumber(value: 5.00))]
        let paymentVC = PKPaymentAuthorizationViewController(paymentRequest: request)!
        let payment = PKPayment()
        
        let expectation = self.expectation(description: "async")
        var statusResult = PKPaymentAuthorizationStatus(rawValue: 0)
        vc.paymentAuthorizationViewController(paymentVC, didAuthorizePayment: payment) { (status) in
            statusResult = status
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(statusResult, PKPaymentAuthorizationStatus.failure)
    }

}
