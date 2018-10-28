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
    var name: String = ""

    init(name: String) {
        self.name = name
    }

    func calculatePrice(minutes _: Int) -> Double {
        // TODO: Implement here
        fatalError("Not implemented yet")
        return 0
    }

    func getScootersInArea(loc _: CLLocation) -> [Scooter] {
        // TODO: Implement here
        fatalError("Not implemented yet")
        return []
    }
}
