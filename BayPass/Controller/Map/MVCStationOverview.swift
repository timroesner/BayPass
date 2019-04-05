//
//  MVCStationOverview.swift
//  BayPass
//
//  Created by Ayesha Khan on 4/1/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import MapKit
import UIKit

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
        removeChild(bottomSheet)
        mapView.removeAnnotations(mapView.annotations)

        let coordinate = CLLocationCoordinate2D(latitude: station.location.coordinate.longitude, longitude: station.location.coordinate.latitude)

        let coordinatRegion = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
        let stationPin = StationPin(title: station.name, imageName: station.getIcon(), coordinate: coordinate)
        mapView.setRegion(mapView.regionThatFits(coordinatRegion), animated: true)
        mapView.addAnnotation(stationPin)
        showLimeScootersOnMap(at: userLocation)
        showLimeScootersOnMap(at: station.location.coordinate)
    }
}
