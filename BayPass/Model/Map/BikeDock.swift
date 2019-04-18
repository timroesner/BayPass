//
//  BikeDock.swift
//  BayPass
//
//  Created by Ayesha Khan on 10/22/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

import CoreLocation
import UIKit

struct BikeDock {
    static let shared = BikeDock(name: "None", location: CLLocation(latitude: 0, longitude: 0), bikesAvailible: 0)
    var name: String
    var location: CLLocation
    var bikesAvailible: Int

    // Only used for the MapAnnotation
    var color = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
    var icon = UIImage(named: "Bike") ?? UIImage()

    init(name: String, location: CLLocation, bikesAvailible: Int) {
        self.name = name
        self.location = location
        self.bikesAvailible = bikesAvailible
    }

    func getDurationInMinutes(fromMeters: Double, eBike: Bool) -> Int {
        var speed: Double // in meters / second
        if eBike {
            speed = 5.55556
        } else {
            speed = 4.305556
        }
        let minutes = (fromMeters / speed) / 60
        return Int(round(minutes))
    }

    func calculatePrice(fromMinutes: Double) -> Double {
        if fromMinutes <= 30 {
            return 3
        } else {
            let overtime = ((fromMinutes - 30) / 15).rounded(.up)
            return 3 + (overtime * 3)
        }
    }
}
