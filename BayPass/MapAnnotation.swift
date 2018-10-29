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
    var coordinate: CLLocationCoordinate2D
    var location: CLLocation = CLLocation()
    var icon: UIImage = UIImage()
    var color: UIColor
    
    init(coordinate: CLLocationCoordinate2D, location: CLLocation, icon: UIImage, color: UIColor) {
        self.coordinate = coordinate
        self.location = location
        self.icon = icon
        self.color = color
    }

    func createFromScooter(scooter _: Scooter) {
        // TODO: Implement here
        fatalError("Not implemented yet")
    }

    func createFrom() {
        // TODO: Implement here
        fatalError("Not implemented yet")
    }
}
