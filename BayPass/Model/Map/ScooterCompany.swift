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
    var icon: UIImage
    var color: UIColor

    init(name: String, icon: UIImage, color: UIColor) {
        self.name = name
        self.icon = icon
        self.color = color
    }

    func calculatePrice(fromMinutes: Int) -> Double {
        // Using parameter so the formatter doesn't add _
        _ = fromMinutes
        fatalError("calculatePrice() is not implemented yet")
    }

    // MARK: The methods below will most likely differ between companies

    func getScootersAroundLocation(loc _: CLLocation) -> [Scooter] {
        // TODO: Implement here
        fatalError("getScooters() is not implemented yet")
    }

    func getDurationInMinutes(fromMeters: Double) {
        // Using parameter so the formatter doesn't add _
        _ = fromMeters
        fatalError("getDuration() is not implemented yet")
    }
}
