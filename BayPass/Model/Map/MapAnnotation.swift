//
//  MapAnnotation.swift
//  BayPass
//
//  Created by Ayesha Khan on 10/20/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

import CoreLocation
import MapKit
import UIKit

class MapAnnotation: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var icon: UIImage
    var color: UIColor

    init(title: String, coordinate: CLLocationCoordinate2D, icon: UIImage, color: UIColor) {
        self.title = title
        self.coordinate = coordinate
        self.icon = icon
        self.color = color
    }

    init(fromScooter: Scooter) {
        title = "\(fromScooter.company.name) Scooter"
        coordinate = fromScooter.location.coordinate
        icon = fromScooter.company.icon
        color = fromScooter.company.color
    }

    init(fromStation: Station) {
        title = fromStation.name
        coordinate = fromStation.location.coordinate
        icon = fromStation.getIcon()
        color = fromStation.color
    }

    init(fromBikeDock: BikeDock) {
        title = fromBikeDock.name
        coordinate = fromBikeDock.location.coordinate
        icon = fromBikeDock.icon
        color = fromBikeDock.color
    }
}
