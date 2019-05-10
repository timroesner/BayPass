//
//  ClipperPassCheckoutViewController.swift
//  BayPass
//
//  Created by Zhe Li on 4/15/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import Stripe
import UIKit

class ClipperPassCheckoutViewController: UIViewController {
    var agency = Agency.zero
    var dropDownOptions = [(title: String, values: [String])]()
    var payButton: BayPassButton?
    var stackedViews = [UIView]()
    var currentPassPrice = 0.0
    var paymentSucceded = false
    var newPass: Pass?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        title = agency.stringValue
        navigationController?.navigationBar.prefersLargeTitles = false
        dropDownOptions = TicketManager.shared.getDropDownOptions(for: agency, onlyPasses: true)
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
            dropDown.delegate = self
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
        payButton = BayPassButton(title: "Pay", color: color)
        payButton?.addTarget(self, action: #selector(pay), for: .touchUpInside)
        view.addSubview(payButton!)
        payButton?.snp.makeConstraints { (make) -> Void in
            make.top.greaterThanOrEqualTo(stackedViews.last!.snp.bottom).offset(25)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
            make.right.left.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }

        // Update Button with price of preselected options
        if let dropDown = stackedViews[safe: 1] as? DropDownMenu {
            didChangeSelectedItem(dropDown)
        }
    }

    @objc func pay() {
        let paymentOption = (stackedViews[safe: stackedViews.count - 1] as? DropDownMenu)?.getSelectedItem() ?? ""
        let passTypeDropDown = stackedViews[safe: 1] as? DropDownMenu
        let passSubTypeDropDown = stackedViews[safe: 2] as? DropDownMenu
        var subType = ""
        if passSubTypeDropDown?.titleLbl.text == "SUB TYPE" {
            subType = subType + " - " + (passSubTypeDropDown?.getSelectedItem() ?? "")
        }
        newPass = TicketManager.shared.createNewClipperPass(agency: agency, passType: passTypeDropDown?.getSelectedItem() ?? "", subType: subType, price: currentPassPrice)

        if currentPassPrice != 0.0 {
            switch PaymentMethod(rawValue: paymentOption) ?? .applePay {
            case .applePay:
                checkoutWithApplePay(items: [(name: newPass?.name ?? "", amount: currentPassPrice)], delegate: self)
                return
            case .creditDebit:
                let addCardViewController = STPAddCardViewController()
                addCardViewController.delegate = self
                navigationController?.pushViewController(addCardViewController, animated: true)
                return
            }
        } else {
            displayAlert(title: "Invalid", msg: "The price of the current pass is 0.0", dismissAfter: false)
        }
    }
}

extension ClipperPassCheckoutViewController: STPAddCardViewControllerDelegate {
    func addCardViewControllerDidCancel(_: STPAddCardViewController) {
        navigationController?.popViewController(animated: true)
    }

    func addCardViewController(_: STPAddCardViewController, didCreateToken _: STPToken, completion: @escaping STPErrorBlock) {
        UserManager.shared.addPass(pass: newPass!)
        completion(nil)

        navigationController?.popToRootViewController(animated: true)
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
            self.paymentSucceded = true
            UserManager.shared.addPass(pass: self.newPass!)
        }
    }

    func paymentAuthorizationViewControllerDidFinish(_: PKPaymentAuthorizationViewController) {
        dismiss(animated: true, completion: {
            if self.paymentSucceded {
                self.navigationController?.popToRootViewController(animated: true)
            }
        })
    }
}
