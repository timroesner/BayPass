//
//  StationPin.swift
//  BayPass
//
//  Created by Ayesha Khan on 4/4/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import Foundation
import MapKit

class StationPin: NSObject, MKAnnotation {
    let title: String?
    let imageName: UIImage?
    let coordinate: CLLocationCoordinate2D

    init(title: String, imageName: UIImage, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.imageName = imageName
        self.coordinate = coordinate

        super.init()
    }
}
