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
    var duration: DateInterval?
    var count: Int = 0
    var price: Double
    var validOnAgency: Agency
    var NFCCode: String
    var locations: [CLLocation]

    init(name: String, duration: DateInterval, price: Double, validOnAgency: Agency, NFCCode: String,
         locations: [CLLocation]) {
        self.name = name
        self.duration = duration
        self.price = price
        self.validOnAgency = validOnAgency
        self.NFCCode = NFCCode
        self.locations = locations
    }

    init(name: String, count: Int, price: Double, validOnAgency: Agency, NFCCode: String,
         locations: [CLLocation]) {
        self.name = name
        self.count = count
        self.price = price
        self.validOnAgency = validOnAgency
        self.NFCCode = NFCCode
        self.locations = locations
    }

    func isValid() -> Bool {
        if let duration = self.duration {
            return duration.end >= Date()
        }
        return count > 0
    }
}
