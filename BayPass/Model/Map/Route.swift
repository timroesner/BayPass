//
//  Routes.swift
//  BayPass
//
//  Created by Ayesha Khan on 10/24/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

import CoreLocation
import MapKit
import UIKit

class Route {
    var departureTime: Date
    var arrivalTime: Date
    var segments: [RouteSegment]

    init(departureTime: Date, arrivalTime: Date, segments: [RouteSegment]) {
        self.departureTime = departureTime
        self.arrivalTime = arrivalTime
        self.segments = segments
        calculateBartPrice()
    }

    func getPrice() -> String {
        var total = 0.0
        var isEstimate = ""
        
        for segment in segments {
            if segment.price == 0.0, segment.line != nil, segment.line?.agency != .BART {
                isEstimate = "~"
            }
            total += segment.price
        }
        return isEstimate+String(format: "$%.2f", total)
    }
    
    func getPrice() -> Double {
        var total = 0.0
        
        for segment in segments {
            total += segment.price
        }
        return total
    }
    
    func calculateBartPrice() {
        for (index, segment) in segments.enumerated() {
            if segment.line?.agency == .BART {
                let depStopKey = segment.waypoints.first ?? ""
                var arrivalStopKey = segment.waypoints.last ?? ""
                
                var currentIndex = index+1
                var currentSegment = segments[currentIndex]
                while currentSegment.line?.agency == .BART {
                    arrivalStopKey = currentSegment.waypoints.last ?? ""
                    currentIndex += 1
                    currentSegment = segments[currentIndex]
                }
                
                let depStop = Parse().BARTGoogleToGTFS[depStopKey] ?? depStopKey
                let arrivalStop = Parse().BARTGoogleToGTFS[arrivalStopKey] ?? arrivalStopKey
                TicketManager.shared.getBARTPrice(from: depStop, to: arrivalStop) { (price) in
                    segment.price = price
                    NotificationCenter.default.post(Notification(name: .didUpdatePrice))
                }
                break
            }
        }
    }

    func getPolylines() -> [MKPolyline] {
        var result = [MKPolyline]()
        for segment in segments {
            segment.polyline.title = segment.travelMode.rawValue
            if let line = segment.line {
                segment.polyline.subtitle = line.color.encode()
            }
            result.append(segment.polyline)
        }
        return result
    }

    func getBoundingMapRect() -> MKMapRect? {
        let polylines = getPolylines()
        if let initialRect = polylines.first?.boundingMapRect {
            var boundingRect = initialRect

            for polyline in polylines {
                boundingRect = polyline.boundingMapRect.union(boundingRect)
            }
            return boundingRect
        }
        return nil
    }
}
