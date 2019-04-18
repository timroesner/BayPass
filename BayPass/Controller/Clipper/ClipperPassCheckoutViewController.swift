//
//  ClipperPassCheckoutViewController.swift
//  BayPass
//
//  Created by Zhe Li on 4/15/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import UIKit
import Stripe

class ClipperPassCheckoutViewController: UIViewController {
    var agency = Agency.zero
    var dropDownOptions: [(title: String, values: [String])] = [
        (title: "Ticket Type", values: ["Day Pass", "3 Day Pass", "Monthly Pass"]),
        (title: "Payment Method", values: PaymentMethod.allCases.map { $0.rawValue }),
    ]
    private var stackedViews = [UIView]()

    // MARK: temporary data, waiting for integration of Ticket/Pass Manager
    var currentPassPrice = 1.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        title = agency.stringValue
        navigationController?.navigationBar.prefersLargeTitles = false
        setUpTicketView(newTicketView: TicketView(agency: agency, icon: agency.getIcon(), cornerRadius: 12))
        setupDropDowns()
    }

    func setUpTicketView(newTicketView: TicketView) {
        view.addSubview(newTicketView)
        newTicketView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(25).priority(.low)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(newTicketView.snp.width).multipliedBy(0.6)
        }
        newTicketView.layoutIfNeeded()
        stackedViews.append(newTicketView)
    }

    func setupDropDowns() {
        for option in dropDownOptions {
            let dropDown = DropDownMenu(title: option.title, items: option.values)
            view.addSubview(dropDown)
            dropDown.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(stackedViews.last!.snp.bottom).offset(25)
                make.left.right.equalToSuperview().inset(12)
            }
            stackedViews.append(dropDown)
        }
        setUpButton(color: agency.getColor())
    }

    func setUpButton(color: UIColor) {
        let payButton = BayPassButton(title: "Pay $xx.xx", color: color)
        payButton.addTarget(self, action: #selector(pay), for: .touchUpInside)
        view.addSubview(payButton)
        payButton.snp.makeConstraints { (make) -> Void in
            make.top.greaterThanOrEqualTo(stackedViews.last!.snp.bottom).offset(25)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
            make.right.left.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }

    @objc func pay() {
        //print("pay")
        
        let paymentDropDown = stackedViews[safe: 2] as? DropDownMenu
        //print(paymentDropDown?.getSelectedItem() ?? "default")
        if currentPassPrice != 0.0 {
            switch PaymentMethod(rawValue: (paymentDropDown?.getSelectedItem())!) ?? .applePay {
            case .applePay:
                checkoutWithApplePay(items: [(name: "Cash Value", amount: currentPassPrice)], delegate: self)
                return
            case .creditDebit:
                print("Credit / Debit")
                return
            }
        } else {
            displayAlert(title: "Invalid", msg: "The price of the current pass is 0.0", dismissAfter: false)
        }
    }
}

extension ClipperPassCheckoutViewController: PKPaymentAuthorizationViewControllerDelegate {
    func paymentAuthorizationViewController(_: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, completion: @escaping (PKPaymentAuthorizationStatus) -> Void) {
        STPAPIClient.shared().createToken(with: payment) { (token: STPToken?, error: Error?) in
            guard let token = token, error == nil else {
                completion(.failure)
                return
            }
            
            // Here we could call our backend if we actually would submit the payment
            print(token)
            completion(.success)
        }
    }
    
    func paymentAuthorizationViewControllerDidFinish(_: PKPaymentAuthorizationViewController) {
        dismiss(animated: true, completion: {
            // To-Do: Add the pass to UserManager
            //UserManager.shared.addCashToCard(amount: self.currentPassPrice)
            self.dismissOrPop(animated: true)
        })
    }
}
