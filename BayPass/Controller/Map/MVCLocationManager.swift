//
//  MVCLocationManager.swift
//  BayPass
//
//  Created by Tim Roesner on 2/28/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import CoreLocation
import MapKit

extension MapViewController: CLLocationManagerDelegate {
    func setupLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func centerOnUserLocation() {
        if let userLocation = locationManager.location?.coordinate {
            let region = MKCoordinateRegion(center: userLocation, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
            mapView.setRegion(region, animated: true)
            Bird().getScooters(fromLocation: userLocation, radius: 5000.0) { scooters in
                let annotations = scooters.map({ MapAnnotation(fromScooter: $0) })
                self.mapView.addAnnotations(annotations)
            }
        }
    }
}
