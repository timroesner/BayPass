//
//  Coordinates.swift
//  BayPass
//
//  Created by Ayesha Khan on 4/5/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import Foundation
import MapKit

struct Coordinates {
    var center: CLLocationCoordinate2D
    var radius: Int
    var max: Int

    init(center: CLLocationCoordinate2D, radius: Int, max: Int) {
        self.center = center
        self.radius = radius
        self.max = max
    }
}
