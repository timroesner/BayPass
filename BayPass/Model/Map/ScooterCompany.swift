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

    func calculatePrice(fromMinutes: Int) -> Double {
        // TODO: Implement here
        fatalError("calculatePrice() is not implemented yet")
    }

    // MARK: The methods below will most likely differ between companies
    func getScootersAroundLocation(loc _: CLLocation) -> [Scooter] {
        // TODO: Implement here
        fatalError("getScooters() is not implemented yet")
    }
    
    func getDurationInMinutes(fromMeters: Double) {
        // TODO: Implement here
        fatalError("getDuration() is not implemented yet")
    }
}
