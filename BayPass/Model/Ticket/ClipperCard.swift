//
//  ClipperCard.swift
//  BayPass
//
//  Created by Ayesha Khan on 10/22/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

import UIKit

struct ClipperCard {
    var number: Int = 0
    var cashValue: Double = 0
    var passes: [Pass] = [Pass]()

    init(number: Int, cashValue: Double, passes: [Pass]) {
        self.number = number
        self.cashValue = cashValue
        self.passes = passes
    }

    func addCash(amount _: Double) {
        // TODO: Implement here
        fatalError("Not implemented yet")
    }

    func addPass(new _: Pass) {
        // TODO: Implement here
        fatalError("Not implemented yet")
    }
}
