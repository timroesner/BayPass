//
//  StationPinView.swift
//  BayPass
//
//  Created by Ayesha Khan on 4/4/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import Foundation
import MapKit

class StationPinView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let station = newValue as? StationPin else { return }
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)

            if let image = station.imageName {
                glyphImage = image
            } else {
                glyphImage = nil
            }
        }
    }
}
