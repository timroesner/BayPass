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

        // Caltrain Stations
        let c103 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.400300, longitude: -122.063873), radius: 1500, max: 50) // Sunnyvale Station
        let c63 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.400300, longitude: -122.063873), radius: 1500, max: 50) // Mountain View Station
        let c118 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.429200, longitude: -122.141900), radius: 500, max: 50) // California Avenue Train Station
        let c111 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.447467, longitude: -122.171221), radius: 1500, max: 50) // Palo Alto Station Menlo Park Station
        let c79 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.490823, longitude: -122.222716), radius: 1500, max: 50) // Redwood City Station
        let c92 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.574715, longitude: -122.335136), radius: 1500, max: 50) // San Mateo Station

        // Bart Stations
        let b1 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.804800, longitude: -122.295100), radius: 500, max: 50)
        let b2 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.502200, longitude: -121.939300), radius: 500, max: 50)
        let b3 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.590600, longitude: -122.017400), radius: 500, max: 50)
        let b4 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.634400, longitude: -122.057200), radius: 500, max: 50)
        let b6 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.616000, longitude: -122.392500), radius: 500, max: 50)
        let b7 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.844700, longitude: -122.251400), radius: 500, max: 50)
        let b8 = Coordinates(center: CLLocationCoordinate2D(latitude: 38.016900, longitude: -121.889100), radius: 500, max: 50)
        let b9 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.878400, longitude: -122.183700), radius: 500, max: 50)
        let b10 = Coordinates(center: CLLocationCoordinate2D(latitude: 38.003200, longitude: -122.024700), radius: 500, max: 50)
        let b11 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.829100, longitude: -122.267000), radius: 500, max: 50)
        let b12 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.893200, longitude: -122.124700), radius: 500, max: 50)
        let b14 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.557500, longitude: -121.976600), radius: 500, max: 50)
        let b15 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.902600, longitude: -122.298900), radius: 500, max: 50)
        let b16 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.701600, longitude: -121.899200), radius: 500, max: 50)
        let b17 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.706200, longitude: -122.468900), radius: 500, max: 50)
        let b18 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.684600, longitude: -122.466300), radius: 500, max: 50)
        let b19 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.781632, longitude: -122.411333), radius: 1000, max: 50)
        let b20 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.696900, longitude: -122.126500), radius: 500, max: 50)
        let b21 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.853000, longitude: -122.270000), radius: 500, max: 50)
        let b22 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.752300, longitude: -122.418500), radius: 500, max: 50)
        let b23 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.765400, longitude: -122.419600), radius: 500, max: 50)
        let b24 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.801493, longitude: -122.275756), radius: 500, max: 50)
        let b25 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.699700, longitude: -121.928200), radius: 500, max: 50)
        let b26 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.905700, longitude: -122.067500), radius: 500, max: 50)
        let b27 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.664200, longitude: -122.444000), radius: 500, max: 50)
        let b28 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.721900, longitude: -122.160800), radius: 500, max: 50)
        let b29 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.637800, longitude: -122.416300), radius: 500, max: 50)
        let b30 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.936800, longitude: -122.354000), radius: 500, max: 50)
        let b31 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.928700, longitude: -122.055700), radius: 500, max: 50)
        let b32 = Coordinates(center: CLLocationCoordinate2D(latitude: 38.018900, longitude: -121.945100), radius: 500, max: 50)
        let b33 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.712800, longitude: -122.212100), radius: 500, max: 50)
        let b34 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.874000, longitude: -122.283400), radius: 500, max: 50)
        let b35 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.600200, longitude: -122.386800), radius: 500, max: 50)
        let b36 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.797000, longitude: -122.265200), radius: 500, max: 50)
        let b37 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.669800, longitude: -122.086900), radius: 500, max: 50)
        let b38 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.774800, longitude: -122.224200), radius: 500, max: 50)
        let b39 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.792050, longitude: -122.398419), radius: 500, max: 50)
        let b40 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.925200, longitude: -122.316900), radius: 500, max: 50)
        let b41 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.870100, longitude: -122.268100), radius: 500, max: 50)
        let b42 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.973700, longitude: -122.029100), radius: 500, max: 50)
        let b43 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.753800, longitude: -122.197000), radius: 500, max: 50)
        let b44 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.690700, longitude: -122.075600), radius: 500, max: 50)
        let b45 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.721600, longitude: -122.447500), radius: 500, max: 50)
        let b46 = Coordinates(center: CLLocationCoordinate2D(latitude: 38.017800, longitude: -121.816200), radius: 500, max: 50)
        let b47 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.808800, longitude: -122.268500), radius: 500, max: 50)

        // San Jose

        // Caltrain Stations
        coordinates.append(c103)
        coordinates.append(c63)
        coordinates.append(c118)
        coordinates.append(c111)
        coordinates.append(c79)
        coordinates.append(c92)

        // Bart Stations
        coordinates.append(b1)
        coordinates.append(b2)
        coordinates.append(b3)
        coordinates.append(b4)
        coordinates.append(b6)
        coordinates.append(b7)
        coordinates.append(b8)
        coordinates.append(b9)
        coordinates.append(b10)
        coordinates.append(b11)
        coordinates.append(b12)
        coordinates.append(b14)
        coordinates.append(b15)
        coordinates.append(b16)
        coordinates.append(b17)
        coordinates.append(b18)
        coordinates.append(b19)
        coordinates.append(b20)
        coordinates.append(b21)
        coordinates.append(b22)
        coordinates.append(b23)
        coordinates.append(b24)
        coordinates.append(b25)
        coordinates.append(b26)
        coordinates.append(b27)
        coordinates.append(b28)
        coordinates.append(b29)
        coordinates.append(b30)
        coordinates.append(b31)
        coordinates.append(b32)
        coordinates.append(b33)
        coordinates.append(b34)
        coordinates.append(b35)
        coordinates.append(b36)
        coordinates.append(b37)
        coordinates.append(b38)
        coordinates.append(b39)
        coordinates.append(b40)
        coordinates.append(b41)
        coordinates.append(b42)
        coordinates.append(b43)
        coordinates.append(b44)
        coordinates.append(b45)
        coordinates.append(b46)
        coordinates.append(b47)

        return coordinates
    }
}
