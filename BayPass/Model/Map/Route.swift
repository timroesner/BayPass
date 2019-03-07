//
//  Routes.swift
//  BayPass
//
//  Created by Ayesha Khan on 10/24/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

import CoreLocation
import UIKit
import MapKit

struct Route {
    var departureTime: Date
    var arrivalTime: Date
    var segments: [RouteSegment]

    init(departureTime: Date, arrivalTime: Date, segments: [RouteSegment]) {
        self.departureTime = departureTime
        self.arrivalTime = arrivalTime
        self.segments = segments
    }
    
    func getPrice() -> String {
        var total = 0.0
        for segment in segments {
            total += segment.price
        }
        return String(format: "$%.2f", total)
    }
    
    func getPolylines() -> [MKPolyline] {
        var result = [MKPolyline]()
        for segment in segments {
            segment.polyline.title = segment.travelMode.rawValue
            if let line = segment.line {
                // TODO: Replace with line color
                segment.polyline.subtitle = UIColor(red: 74, green: 144, blue: 226).encode()
            }
            result.append(segment.polyline)
        }
        return result
    }
}
