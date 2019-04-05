//
//  MVCStationOverview.swift
//  BayPass
//
//  Created by Ayesha Khan on 4/1/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import MapKit
import UIKit

extension MapViewController {
    func displayStationInfo(to station: Station) {
        var userLocation: CLLocationCoordinate2D
        if ProcessInfo.processInfo.arguments.contains("UITests") {
            userLocation = CLLocationCoordinate2D(latitude: 37.331348, longitude: -121.888877)
        } else {
            guard let realUserLocation = locationManager.location?.coordinate else {
                displayAlert(title: "User Location unknown", msg: "Please allow BayPass to access your current location, to plan a route to this destination.", dismissAfter: false)
                return
            }
            userLocation = realUserLocation
        }

        bottomSheet.moveOverlay(toNotchAt: 0, animated: true)
        bottomSheet.willMove(toParent: nil)
        bottomSheet.view.removeFromSuperview()
        bottomSheet.removeFromParent()
        mapView.removeAnnotations(mapView.annotations)

        let coordinate = CLLocationCoordinate2D(latitude: station.location.coordinate.longitude, longitude: station.location.coordinate.latitude)

        let coordinatRegion = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
        mapView.setRegion(mapView.regionThatFits(coordinatRegion), animated: true)
        showLimeScootersOnMap(at: userLocation)
        showLimeScootersOnMap(at: station.location.coordinate)
    }
}
