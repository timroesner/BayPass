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
    var code: String = ""
    var location: CLLocation = CLLocation()
    var battery: String = ""
    var company: ScooterCompany = ScooterCompany(name: "")
}
