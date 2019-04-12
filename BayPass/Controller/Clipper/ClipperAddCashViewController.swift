//
//  ClipperAddCashViewController.swift
//  BayPass
//
//  Created by 凌脩羽 on 3/6/19.
//  Implemented by Tim on 4/5/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import SkyFloatingLabelTextField
import SnapKit
import Stripe
import UIKit

class ClipperAddCashViewController: UIViewController {
    var valueTextField = SkyFloatingLabelTextField()
    let dropDown = DropDownMenu(title: "Payment Method", items: PaymentMethod.allCases.map { $0.rawValue })
    var value = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Add Cash Value"
        navigationController?.navigationBar.prefersLargeTitles = false

        setupView()
    }

    func setupView() {
        guard let clipperCard = ClipperManager.shared.getClipperCard() else {
            displayAlert(title: "No card found", msg: "You don't have a Clipper card saved yet", dismissAfter: true)
            return
        }

        let clipperView = ClipperView(cardNumber: clipperCard.number, cashValue: clipperCard.cashValue)
        view.addSubview(clipperView)
        clipperView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(clipperView.snp.width).multipliedBy(0.6)
        }

        valueTextField.placeholder = "Value"
        valueTextField.title = "ADD"
        valueTextField.titleFont = UIFont.systemFont(ofSize: 17, weight: .semibold)
        valueTextField.selectedTitleColor = .lightGray
        valueTextField.keyboardType = .decimalPad
        valueTextField.addTarget(self, action: #selector(handleValueInput(_:)), for: .editingChanged)
        valueTextField.font = UIFont.systemFont(ofSize: 54, weight: .bold)
        valueTextField.addDoneButtonToKeyboard()
        view.addSubview(valueTextField)
        valueTextField.snp.makeConstraints { make in
            make.top.equalTo(clipperView.snp.bottom).offset(38)
            make.centerX.equalToSuperview()
            make.width.equalTo(230)
        }

        view.addSubview(dropDown)
        dropDown.snp.makeConstraints { make in
            make.top.equalTo(valueTextField.snp.bottom).offset(38)
            make.left.right.equalToSuperview().inset(20)
        }

        let payButton = BayPassButton(title: "Pay Amount", color: UIColor().clipperBlue)
        payButton.addTarget(self, action: #selector(pay), for: .touchUpInside)
        view.addSubview(payButton)
        payButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }

    @objc func handleValueInput(_ textField: SkyFloatingLabelTextField) {
        if let text = textField.text,
            textField.text != "",
            !(textField.text?.contains("$") ?? false) {
            textField.text = "$" + text
        }

        if textField.text == "$" {
            textField.text = ""
        }

        if let text = textField.text,
            textField.text != "" {
            let textValue = text.dropFirst()
            value = Double(textValue) ?? 0.0
            if value > 300.0 {
                textField.errorMessage = "Max value is $300"
            } else if value < 1.0 {
                textField.errorMessage = "Min value is $1"
            } else {
                textField.errorMessage = ""
            }
        }
    }

    @objc func pay() {
        if value != 0.0, valueTextField.errorMessage == "" {
            switch PaymentMethod(rawValue: dropDown.getSelectedItem()) ?? .applePay {
            case .applePay:
                checkoutWithApplePay(items: [(name: "Cash Value", amount: value)], delegate: self)
                return
            case .creditDebit:
                print("Credit / Debit")
                return
            }
        } else {
            displayAlert(title: "Invalid", msg: "Please make sure all fields are filled and correct", dismissAfter: false)
        }
    }
}

extension ClipperAddCashViewController: PKPaymentAuthorizationViewControllerDelegate {
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
            ClipperManager.shared.addCashToCard(amount: self.value)
            self.dismissOrPop(animated: true)
        })
    }
}
