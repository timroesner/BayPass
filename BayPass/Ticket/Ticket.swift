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
    var name: String = ""
    var duration: TimeInterval = TimeInterval()
    var price: Double = 0
    var validOnAgency: Agency
    var NFCCode: String = ""
    var locations: [CLLocation] = [CLLocation()]

    func isValid() -> Bool {
        // TODO: Implement here
        return false
    }
}
