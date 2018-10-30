//
//  Pass.swift
//  BayPass
//
//  Created by Ayesha Khan on 10/22/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

import CoreLocation
import UIKit

struct Pass {
    var name: String
    var duration: DateInterval
    var price: Double
    var validOnAgency: Agency

    init(name: String, duration: DateInterval, price: Double, validOnAgency: Agency) {
        self.name = name
        self.duration = duration
        self.price = price
        self.validOnAgency = validOnAgency
    }

    func isValid() -> Bool {
        // TODO: Implement here
        fatalError("isValid() is not implemented yet")
    }
}
