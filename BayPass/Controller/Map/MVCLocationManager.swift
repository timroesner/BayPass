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

    @objc func centerOnUserLocation() {
        if let userLocation = locationManager.location?.coordinate {
            if routes.isEmpty {
                let region = MKCoordinateRegion(center: userLocation, span: MKCoordinateSpan(latitudeDelta: 0.015, longitudeDelta: 0.015))
                mapView.setRegion(region, animated: true)
                showBirdScootersOnMap(at: userLocation, radius: 50)
                showLimeScootersOnMap(at: userLocation)
            }
        }
    }
}
