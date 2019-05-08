//
//  TicketViewControllerTests.swift
//  BayPassTests
//
//  Created by Tim Roesner on 5/4/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

@testable import BayPass
import XCTest
import Stripe

class TicketViewControllerTests: XCTestCase {
    
    let vc = TicketViewController()

    override func setUp() {
        let ticket = Ticket(name: "Single Ride", count: 1, price: 2.50, validOnAgency: .VTA)
        UserManager.shared.addPurchased(ticket: ticket)
        UIApplication.shared.keyWindow!.rootViewController = vc
        XCTAssertNotNil(UIApplication.shared.keyWindow?.rootViewController)
    }

    override func tearDown() {
        UserManager.shared.clearAllPurchasedTickets()
    }

    func testTableView() {
        vc.purchasedTicketTableView.reloadData()
        let cell = vc.tableView(vc.purchasedTicketTableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertNotNil(cell)
        vc.tableView(vc.purchasedTicketTableView, didSelectRowAt: IndexPath(row: 0, section: 0))
    }
    
    func testCheckoutDropDownCalTrain() {
        let vc = TicketCheckoutViewController()
        vc.agency = .CalTrain
        UIApplication.shared.keyWindow!.rootViewController = vc
        XCTAssertNotNil(UIApplication.shared.keyWindow?.rootViewController)
        vc.updateCalTrainTicketPrice()
    }
    
    func testCheckoutDropDownVTA() {
        let vc = TicketCheckoutViewController()
        vc.agency = .VTA
        UIApplication.shared.keyWindow!.rootViewController = vc
        XCTAssertNotNil(UIApplication.shared.keyWindow?.rootViewController)
        vc.updateTicketPrice()
        vc.pay()
    }
    
    func testCheckoutDropDownBART() {
        let vc = TicketCheckoutViewController()
        vc.agency = .BART
        UIApplication.shared.keyWindow!.rootViewController = vc
        XCTAssertNotNil(UIApplication.shared.keyWindow?.rootViewController)
        vc.updateBARTTicketPrice()
        vc.pay()
    }
    
    func testDidFinish() {
        let vc = TicketCheckoutViewController()
        let request = Stripe.paymentRequest(withMerchantIdentifier: Credentials().merchantId, country: "US", currency: "USD")
        request.paymentSummaryItems = [PKPaymentSummaryItem(label: "TestItem", amount: NSDecimalNumber(value: 5.00))]
        let paymentVC = PKPaymentAuthorizationViewController(paymentRequest: request)!
        vc.paymentAuthorizationViewControllerDidFinish(paymentVC)
        
        let presentedVC = UIApplication.shared.keyWindow?.rootViewController?.presentedViewController
        XCTAssertFalse(presentedVC is TicketCheckoutViewController)
    }
    
    func testDidAuthorize() {
        let vc = TicketCheckoutViewController()
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
