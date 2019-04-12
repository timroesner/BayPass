//
//  SystemCoordinates.swift
//  BayPass
//
//  Created by Ayesha Khan on 4/11/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import Foundation
import MapKit

extension System {
    func getAllCoordinates() -> [Coordinates] {
        var coordinates = [Coordinates]()

        let c1 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.309690, longitude: -121.940223), radius: 1500, max: 50)
        let c2 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.338489, longitude: -121.945763), radius: 1500, max: 50)
        let c3 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.320425, longitude: -121.907463), radius: 1500, max: 50)
        let c4 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.341991, longitude: -121.877350), radius: 1500, max: 50)
        let c5 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.311733, longitude: -121.874423), radius: 1500, max: 50)
        let c6 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.692235, longitude: -122.462882), radius: 1500, max: 50)

        coordinates.append(c1)
        coordinates.append(c2)
        coordinates.append(c3)
        coordinates.append(c4)
        coordinates.append(c5)
        coordinates.append(c6)
        return coordinates
    }
}
