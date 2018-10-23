//
//  Ticket.swift
//  BayPass
//
//  Created by Ayesha Khan on 10/22/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

import CoreLocation
import UIKit

struct Ticket {
    var name: String
    var duration: TimeInterval
    var price: Double
    var validOnAgency: Agency
    var NFCCode: String
    var locations: [CLLocation]

    func isValid() -> Bool {
        return false
    }
}
