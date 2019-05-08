//
//  ViewController.swift
//  BayPass
//
//  Created by Tim Roesner on 3/2/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import Stripe
import UIKit

extension UIViewController {
    func displayAlert(title: String, msg: String, dismissAfter: Bool) {
        let confirm = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        confirm.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (_: UIAlertAction) in
            if dismissAfter {
                self.dismissOrPop(animated: true)
            }
        }))

        present(confirm, animated: true, completion: nil)
    }

    func dismissOrPop(animated: Bool) {
        if let navController = self.navigationController {
            navController.popViewController(animated: animated)
        } else {
            dismiss(animated: animated, completion: nil)
        }
    }

    func checkoutWithApplePay(items: [(name: String, amount: Double)], delegate: PKPaymentAuthorizationViewControllerDelegate) {
        if Stripe.deviceSupportsApplePay() == false {
            displayAlert(title: "Apple Pay Error", msg: "It seems like your device is not set up for Apple Pay. Please choose a different method", dismissAfter: false)
        }

        let paymentRequest = Stripe.paymentRequest(withMerchantIdentifier: Credentials().merchantId, country: "US", currency: "USD")

        paymentRequest.paymentSummaryItems = items.map {
            PKPaymentSummaryItem(label: $0.name, amount: NSDecimalNumber(value: $0.amount))
        }

        if Stripe.canSubmitPaymentRequest(paymentRequest) {
            let paymentAuthorizationViewController = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest)!
            paymentAuthorizationViewController.delegate = delegate
            present(paymentAuthorizationViewController, animated: true)
        } else {
            print("Apple Pay error")
        }
    }
    
    open override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            resetUserDataAlert()
        }
    }
    
    private func resetUserDataAlert() {
        let alert = UIAlertController(title: "Reset", message: "Are you sure you want to delete all user data? This inlcudes Clipper Card and all purchased Tickets.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
            UserManager.shared.removeCard()
            UserManager.shared.clearAllPurchasedTickets()
            self.viewWillAppear(false)
        }))
        present(alert, animated: true, completion: nil)
    }
}
