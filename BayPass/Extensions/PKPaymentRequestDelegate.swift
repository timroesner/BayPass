//
//  PKPaymentRequestDelegate.swift
//  BayPass
//
//  Created by Tim Roesner on 4/6/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import Stripe

extension PKPaymentAuthorizationViewControllerDelegate {
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
}
