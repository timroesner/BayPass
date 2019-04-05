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
    var time: String

    init(center: CLLocationCoordinate2D, radius: Int, max: Int, time: String) {
        self.center = center
        self.radius = radius
        self.max = max
        self.time = time
    }
}
