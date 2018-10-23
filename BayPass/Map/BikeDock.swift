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
    var location: CLLocation = CLLocation(latitude: 0.0, longitude: 0.0)
    var bikesAvailible: Int = 0

    init(location: CLLocation, bikesAvailible: Int) {
        this.location = location
        this.bikesAvailible = bikesAvailible
    }

    func calculatePrice(start _: CLLocation, end _: CLLocation) -> Double {
        // TODO: Implement here
        return 0
    }
}
