//
//  Pass.swift
//  BayPass
//
//  Created by Ayesha Khan on 10/22/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

import UIKit

struct Pass {
    var name: String
    var duration: DateInterval
    var price: Double
    var validOnAgency: Agency

    func isValid() -> Bool {
        return false
    }
}
