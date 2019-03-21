//
//  GoogleMaps.swift
//  BayPass
//
//  Created by Tim Roesner on 2/17/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import Alamofire
import Foundation
import MapKit

class GoogleMaps {
    func getRoutes(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D, departureTime: Date = Date(), completion: @escaping ([Route]) -> Void) {
        let params = [
            "origin": "\(from.latitude),\(from.longitude)",
            "destination": "\(to.latitude),\(to.longitude)",
            "mode": "transit",
            "alternatives": "true",
            "departure_time": String(Int(departureTime.timeIntervalSince1970)),
            "key": Credentials().googleDirections,
        ]

        var results = [Route]()
        Alamofire.request("https://maps.googleapis.com/maps/api/directions/json", method: .get, parameters: params).responseJSON { response in
            if let json = response.result.value as? [String: Any],
                let routesJson = json["routes"] as? [[String: Any]] {
                for routeJson in routesJson {
                    if let newRoute = self.parseRoute(from: routeJson) {
                        results.append(newRoute)
                    }
                }
                completion(results)
            }
        }
    }

    func parseRoute(from json: [String: Any]) -> Route? {
        guard let legs = json["legs"] as? [[String: Any]],
            let arrivalJson = legs[0]["arrival_time"] as? [String: Any],
            let departureJson = legs[0]["departure_time"] as? [String: Any],
            let arrivalInterval = arrivalJson["value"] as? Int,
            let departureInterval = departureJson["value"] as? Int
        else {
            return nil
        }

        let departureDate = Date(timeIntervalSince1970: Double(departureInterval))
        let arrivalDate = Date(timeIntervalSince1970: Double(arrivalInterval))

        var segments = [RouteSegment]()
        if let segmentsJson = legs[0]["steps"] as? [[String: Any]] {
            for segmentJson in segmentsJson {
                if let newSegment = parseSegment(from: segmentJson) {
                    segments.append(newSegment)
                }
            }
        }

        return Route(departureTime: departureDate, arrivalTime: arrivalDate, segments: segments)
    }

    func parseSegment(from json: [String: Any]) -> RouteSegment? {
        guard let distanceJson = json["distance"] as? [String: Any],
            let distance = distanceJson["value"] as? Int,
            let polylineJson = json["polyline"] as? [String: Any],
            let encodedPolyline = polylineJson["points"] as? String
        else {
            return nil
        }

        var polyline = MKPolyline()
        if let coordinates = decodePolyline(encodedPolyline) {
            polyline = MKPolyline(coordinates: coordinates)
        }

        // Transit
        if let transitDetails = json["transit_details"] as? [String: Any] {
            var ag: Agency = Agency.zero

            guard let arrivalJson = transitDetails["arrival_time"] as? [String: Any],
                let arrivalInterval = arrivalJson["value"] as? Int,
                let departureJson = transitDetails["departure_time"] as? [String: Any],
                let departureInterval = departureJson["value"] as? Int,
                let lineJson = transitDetails["line"] as? [String: Any]
            else {
                return nil
            }

            let departureDate = Date(timeIntervalSince1970: Double(departureInterval))
            let arrivalDate = Date(timeIntervalSince1970: Double(arrivalInterval))

            let lineName = lineJson["name"] as? String ?? ""
            if let agencies = lineJson["agencies"] as? [String: Any] {
                let agencyName = agencies["name"] as? String?
                ag = Agency(rawValue: agencyName as! String) ?? Agency.zero
            }

            // TODO: This section relies on getting the fare prices from firebase and the line from the API first
            let line = Line(name: lineName, agency: ag, destination: "De Anza", color: #colorLiteral(red: 0.2901960784, green: 0.5647058824, blue: 0.8862745098, alpha: 1), transitMode: TransitMode.bus)
            let waypoints = [Station]()
            let price = 2.50

            return RouteSegment(distanceInMeters: distance, departureTime: departureDate, arrivalTime: arrivalDate, polyline: polyline, travelMode: .transit, line: line, price: price, waypoints: waypoints)
        } else {
            guard let durationJson = json["duration"] as? [String: Any],
                var duration = durationJson["value"] as? Int
            else {
                return nil
            }
            duration = Int(duration / 60)

            return RouteSegment(distanceInMeters: distance, durationInMinutes: duration, polyline: polyline, travelMode: .walking)
        }
    }
}
