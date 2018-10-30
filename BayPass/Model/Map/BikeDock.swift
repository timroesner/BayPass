//
//  BikeDock.swift
//  BayPass
//
//  Created by Ayesha Khan on 10/22/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

import CoreLocation
import UIKit

struct BikeDock {
    var name: String
    var location: CLLocation
    var bikesAvailible: Int

    // Only used for the MapAnnotation
    var color = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
    var icon = UIImage(named: "Bike") ?? UIImage()

    init(name: String, location: CLLocation, bikesAvailible: Int) {
        self.name = name
        self.location = location
        self.bikesAvailible = bikesAvailible
    }

    func calculatePrice(start _: CLLocation, end _: CLLocation) -> Double {
        // TODO: Implement here
        fatalError("calculatePirce is not implemented yet")
    }
}
