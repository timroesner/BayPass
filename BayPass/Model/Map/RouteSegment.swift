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
    var distanceInMeters: Double
    var departureTime: Date
    var arrivalTime: Date
    var polyline: MKPolyline
    var travelMode: TravelMode
    var headsign: String = ""
    var price: Double = 0.0
    var waypoints = [Station]()

    init(distanceInMeters: Double, departureTime: Date, arrivalTime: Date, polyline: MKPolyline, travelMode: TravelMode) {
        self.distanceInMeters = distanceInMeters
        self.departureTime = departureTime
        self.arrivalTime = arrivalTime
        self.polyline = polyline
        self.travelMode = travelMode
    }

    init(distanceInMeters: Double, departureTime: Date, arrivalTime: Date, polyline: MKPolyline, travelMode: TravelMode, headsign: String, price: Double, waypoints: [Station]) {
        self.distanceInMeters = distanceInMeters
        self.departureTime = departureTime
        self.arrivalTime = arrivalTime
        self.polyline = polyline
        self.travelMode = travelMode
        self.headsign = headsign
        self.price = price
        self.waypoints = waypoints
    }
}
