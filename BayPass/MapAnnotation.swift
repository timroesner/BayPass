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

    var title: String? = ""
    var location: CLLocation?
    var icon: UIImage?

    var myCoordinate: CLLocationCoordinate2D?

    init(myCoordinate: CLLocationCoordinate2D, coordinate: CLLocationCoordinate2D) {
        self.myCoordinate = myCoordinate
        self.coordinate = coordinate
    }

    func createFromScooter(scooter _: Scooter) {
        // TODO: Implement here
    }

    func createFrom() {
        // TODO: Implement here
    }
}
