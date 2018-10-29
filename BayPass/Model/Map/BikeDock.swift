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
    var location: CLLocation
    var bikesAvailible: Int

    init(location: CLLocation, bikesAvailible: Int) {
        self.location = location
        self.bikesAvailible = bikesAvailible
    }

    func calculatePrice(start _: CLLocation, end _: CLLocation) -> Double {
        // TODO: Implement here
        fatalError("calculatePirce is not implemented yet")
    }
}
