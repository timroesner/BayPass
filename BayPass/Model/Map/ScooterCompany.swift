//
//  ScooterCompany.swift
//  BayPass
//
//  Created by Ayesha Khan on 10/22/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

import CoreLocation
import UIKit

struct ScooterCompany: Equatable {
    static let shared = ScooterCompany(name: "None", icon: #imageLiteral(resourceName: "Scooter"), color: .black)
    var name: String
    var icon: UIImage
    var color: UIColor

    init(name: String, icon: UIImage, color: UIColor) {
        self.name = name
        self.icon = icon
        self.color = color
    }

    func calculatePrice(fromMinutes: Int) -> Double {
        // I made sure that's also the way Lime and Bird calculate their prices
        // They don't do half minutes either
        let rate = Double(fromMinutes) * 0.15
        return 1 + rate
    }

    func getDurationInMinutes(fromMeters: Double) -> Int {
        // Using 10 mph as average speed (New law limiting to 12 mph)
        // Which comes out to 4.47 meters per second
        let speed = 4.4704
        let minutes = (fromMeters / speed) / 60
        return Int(round(minutes))
    }
}
