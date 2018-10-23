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
<<<<<<< HEAD
    var name: String = ""
    var duration: TimeInterval = TimeInterval()
    var price: Double = 0
    var validOnAgency: Agency
    var NFCCode: String = ""
    var locations: [CLLocation] = [CLLocation()]

    func isValid() -> Bool {
        // TODO: Implement here
=======
    var name: String
    var duration: TimeInterval
    var price: Double
    var validOnAgency: Agency
    var NFCCode: String
    var locations: [CLLocation]

    func isValid() -> Bool {
>>>>>>> Added the struct based off UML Diagram
        return false
    }
}
