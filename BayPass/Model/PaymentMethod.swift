//
//  PaymentMethod.swift
//  BayPass
//
//  Created by Tim Roesner on 4/5/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import Foundation

enum PaymentMethod: String, CaseIterable {
    case applePay = "Apple Pay"
    case creditDebit = "Credit / Debit Card"
}
