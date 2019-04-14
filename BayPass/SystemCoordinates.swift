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

        // San Jose
        let c48 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.353065, longitude: -121.782045), radius: 1500, max: 50)
        let c44 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.322689, longitude: -121.785528), radius: 1500, max: 50)
        let c45 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.292966, longitude: -121.780044), radius: 1500, max: 50)
        let c49 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.227811, longitude: -121.791948), radius: 1500, max: 50)
        let c47 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.371895, longitude: -121.810347), radius: 1500, max: 50)
        let c43 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.339400, longitude: -121.813733), radius: 1500, max: 50)
        let c31 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.311074, longitude: -121.818655), radius: 1500, max: 50)
        let c32 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.283461, longitude: -121.813508), radius: 1500, max: 50)
        let c35 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.256727, longitude: -121.801805), radius: 1500, max: 50)
        let c36 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.235921, longitude: -121.825548), radius: 1500, max: 50)
        let c33 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.261821, longitude: -121.836933), radius: 1500, max: 50)
        let c30 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.293706, longitude: -121.846366), radius: 1500, max: 50)
        let c14 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.328160, longitude: -121.846873), radius: 1500, max: 50)
        let c15 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.355609, longitude: -121.841402), radius: 1500, max: 50)
        let c46 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.387387, longitude: -121.843149), radius: 1500, max: 50)
        let c17 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.395600, longitude: -121.882624), radius: 1500, max: 50)
        let c13 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.369210, longitude: -121.872842), radius: 1500, max: 50)
        let c1 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.341991, longitude: -121.877350), radius: 1500, max: 50)
        let c29 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.311733, longitude: -121.874423), radius: 1500, max: 50)
        let c4 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.272123, longitude: -121.869633), radius: 1500, max: 50)
        let c28 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.263751, longitude: -121.904545), radius: 1500, max: 50)
        let c37 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.236491, longitude: -121.911759), radius: 1500, max: 50)
        let c41 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.213033, longitude: -121.890514), radius: 1500, max: 50)
        let c40 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.210253, longitude: -121.925378), radius: 1500, max: 50)

        // Campbell
        let c27 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.260086, longitude: -121.958256), radius: 1500, max: 50)
        let c19 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.288244, longitude: -121.966299), radius: 1500, max: 50)
        let c18 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.319486, longitude: -121.972874), radius: 1500, max: 50)
        let c22 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.299705, longitude: -121.998690), radius: 1500, max: 50)
        let c26 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.270023, longitude: -121.993071), radius: 1500, max: 50)
        let c38 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.241805, longitude: -121.987327), radius: 1500, max: 50)
        let c51 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.213054, longitude: -121.974911), radius: 1500, max: 50)

        // Caltrain Stations
        let c103 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.400300, longitude: -122.063873), radius: 1500, max: 50) // Sunnyvale Station
        let c63 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.400300, longitude: -122.063873), radius: 1500, max: 50) // Mountain View Station
        let c118 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.429200, longitude: -122.141900), radius: 500, max: 50) // California Avenue Train Station
        let c111 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.447467, longitude: -122.171221), radius: 1500, max: 50) // Palo Alto Station Menlo Park Station
        let c79 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.490823, longitude: -122.222716), radius: 1500, max: 50) // Redwood City Station
        let c92 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.574715, longitude: -122.335136), radius: 1500, max: 50) // San Mateo Station

        // San Jose
        coordinates.append(c48)
        coordinates.append(c44)
        coordinates.append(c45)
        coordinates.append(c49)
        coordinates.append(c47)
        coordinates.append(c43)
        coordinates.append(c31)
        coordinates.append(c32)
        coordinates.append(c35)
        coordinates.append(c36)
        coordinates.append(c33)
        coordinates.append(c30)
        coordinates.append(c14)
        coordinates.append(c15)
        coordinates.append(c46)
        coordinates.append(c17)
        coordinates.append(c13)
        coordinates.append(c1)
        coordinates.append(c29)
        coordinates.append(c4)
        coordinates.append(c28)
        coordinates.append(c37)
        coordinates.append(c41)
        coordinates.append(c40)

        // Campbell
        coordinates.append(c27)
        coordinates.append(c19)
        coordinates.append(c18)
        coordinates.append(c22)
        coordinates.append(c26)
        coordinates.append(c38)
        coordinates.append(c51)

        // Caltrain Stations
        coordinates.append(c103)
        coordinates.append(c63)
        coordinates.append(c118)
        coordinates.append(c111)
        coordinates.append(c79)
        coordinates.append(c92)

        return coordinates
    }
}
