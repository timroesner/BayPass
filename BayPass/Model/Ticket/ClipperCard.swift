//
//  ClipperCard.swift
//  BayPass
//
//  Created by Ayesha Khan on 10/22/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

import UIKit

struct ClipperCard: Codable {
    var number: Int
    var cashValue: Double
    var passes: [Pass]

    init(number: Int, cashValue: Double, passes: [Pass]) {
        self.number = number
        self.cashValue = cashValue
        self.passes = passes
    }

    mutating func addCash(amount: Double) {
        cashValue += amount
    }

    mutating func addPass(new: Pass) {
        passes.append(new)
    }
}
