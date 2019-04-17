//
//  RouteSegment.swift
//  BayPass
//
//  Created by Tim Roesner on 10/28/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

import CoreLocation
import Foundation
import MapKit

struct RouteSegment {
    var distanceInMeters: Int
    var departureTime: Date?
    var arrivalTime: Date?
    var durationInMinutes: Int
    var polyline: MKPolyline
    var travelMode: TravelMode
    var line: Line?
    var price: Double = 0.0
    var waypoints = [Station]()

    init(distanceInMeters: Int, durationInMinutes: Int, polyline: MKPolyline, travelMode: TravelMode) {
        self.distanceInMeters = distanceInMeters
        self.durationInMinutes = durationInMinutes
        self.polyline = polyline
        self.travelMode = travelMode
    }

    init(distanceInMeters: Int, departureTime: Date, arrivalTime: Date, polyline: MKPolyline, travelMode: TravelMode, line: Line, price: Double, waypoints: [Station]) {
        self.distanceInMeters = distanceInMeters
        self.departureTime = departureTime
        self.arrivalTime = arrivalTime
        durationInMinutes = Int(arrivalTime.timeIntervalSince(departureTime) / 60)
        self.polyline = polyline
        self.travelMode = travelMode
        self.line = line
        self.price = price
        self.waypoints = waypoints
    }
}
