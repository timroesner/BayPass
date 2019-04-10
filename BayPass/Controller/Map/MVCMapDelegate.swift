//
//  MVCMapDelegate.swift
//  BayPass
//
//  Created by Tim Roesner on 3/4/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import MapKit
import UIKit

extension MapViewController: MKMapViewDelegate {
    func mapView(_: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let polylineRenderer = MKPolylineRenderer(overlay: overlay)
        polylineRenderer.lineWidth = 5

        if let polyline = overlay as? MKPolyline {
            let travelMode = TravelMode(rawValue: polyline.title ?? "") ?? .walking
            switch travelMode {
            case .walking:
                polylineRenderer.strokeColor = UIColor().lightGrey
                polylineRenderer.lineDashPattern = [6, 12]
            case .transit:
                if let colorString = polyline.subtitle {
                    polylineRenderer.strokeColor = UIColor(string: colorString)
                }
            case .bike:
                polylineRenderer.strokeColor = .gray
            case .scooter:
                polylineRenderer.strokeColor = .black
            }
        }
        return polylineRenderer
    }

    func showBirdScootersOnMap(at location: CLLocationCoordinate2D, radius: Double) {
        Bird().getScooters(fromLocation: location, radius: radius) { scooters in
            let annotations = scooters.map { MapAnnotation(fromScooter: $0) }
            self.mapView.addAnnotations(annotations)
        }
    }

    func showLimeScootersOnMap(at location: CLLocationCoordinate2D) {
        Lime().getScooters(fromLocation: location) { scooters in
            let annotations = scooters.map { MapAnnotation(fromScooter: $0) }
            self.mapView.addAnnotations(annotations)
        }
    }
}
