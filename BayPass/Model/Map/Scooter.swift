//
//  Scooter.swift
//  BayPass
//
//  Created by Ayesha Khan on 10/22/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

import CoreLocation
import UIKit

struct Scooter {
    var code: String
    var location: CLLocation
    var battery: String
    var company: ScooterCompany

    init(code: String, location: CLLocation, battery: String, company: ScooterCompany) {
        self.code = code
        self.location = location
        self.battery = battery
        self.company = company
    }
}
