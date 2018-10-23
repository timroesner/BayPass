//
//  ScooterCompany.swift
//  BayPass
//
//  Created by Ayesha Khan on 10/22/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

import CoreLocation
import UIKit

struct ScooterCompany {
    var name: String

    func calculatePrice(minutes _: Int) -> Double {
        return 0
    }

    func getScootersInArea(loc _: CLLocation) -> [Scooter] {
        return []
    }
}
