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

    init(name: String, duration: TimeInterval, price: Double, validOnAgency: Agency, NFCCode: String,
         locations: [CLLocation]) {
        self.name = name
        self.duration = duration
        self.price = price
        self.validOnAgency = validOnAgency
        self.NFCCode = NFCCode
        self.locations = locations
    }

    func isValid() -> Bool {
        // TODO: Implement here
        fatalError("Not implemented yet")
        return false
    }
}
