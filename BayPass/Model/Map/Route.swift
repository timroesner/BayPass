//
//  Routes.swift
//  BayPass
//
//  Created by Ayesha Khan on 10/24/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

import CoreLocation
import UIKit

struct Route {
    var departureTime: Date
    var arrivalTime: Date
    var segments: [RouteSegment]

    init(departureTime: Date, arrivalTime: Date, segments: [RouteSegment]) {
        self.departureTime = departureTime
        self.arrivalTime = arrivalTime
        self.segments = segments
    }
}
