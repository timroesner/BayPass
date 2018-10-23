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
    var name: String = ""
    var duration: DateInterval = DateInterval()
    var price: Double = 0
    var validOnAgency: Agency
    func isValid() -> Bool {
        // TODO: Implement here
        return false
    }
}
