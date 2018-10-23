//
//  Pass.swift
//  BayPass
//
//  Created by Ayesha Khan on 10/22/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

<<<<<<< HEAD
import CoreLocation
import UIKit

struct Pass {
    var name: String = ""
    var duration: DateInterval = DateInterval()
    var price: Double = 0
    var validOnAgency: Agency
    func isValid() -> Bool {
        // TODO: Implement here
=======
import UIKit

struct Pass {
    var name: String
    var duration: DateInterval
    var price: Double
    var validOnAgency: Agency

    func isValid() -> Bool {
>>>>>>> Added the struct based off UML Diagram
        return false
    }
}
