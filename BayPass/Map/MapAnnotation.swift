//
//  MapAnnotation.swift
//  BayPass
//
//  Created by Ayesha Khan on 10/20/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

import CoreLocation
import UIKit

struct MapAnnotation {
    var title: String
    var location: CLLocation = CLLocation(latitude: 0, longitude: 0)
    var icon: UIImage

    func createFromScooter(scooter _: Scooter) {}
    func createFromStation(station _: Station) {}
}
