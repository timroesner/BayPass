//
//  Ticket.swift
//  BayPass
//
//  Created by Ayesha Khan on 10/22/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//
import CoreLocation
import UIKit

struct Ticket: Codable, Equatable {
    var name: String
    var duration: DateInterval?
    var count: Int = 0
    var price: Double
    var validOnAgency: Agency

    init(name: String, duration: DateInterval, price: Double, validOnAgency: Agency) {
        self.name = name
        self.duration = duration
        self.price = price
        self.validOnAgency = validOnAgency
    }

    init(name: String, count: Int, price: Double, validOnAgency: Agency) {
        self.name = name
        self.count = count
        self.price = price
        self.validOnAgency = validOnAgency
    }

    func isValid() -> Bool {
        if let duration = self.duration {
            return duration.end >= Date()
        }
        return count > 0
    }
}
