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
        bottomSheet.moveOverlay(toNotchAt: 0, animated: true)
        // removeChild(bottomSheet)
        mapView.removeAnnotations(mapView.annotations)

        let coordinate = CLLocationCoordinate2D(latitude: station.location.coordinate.latitude, longitude: station.location.coordinate.longitude)

        let coordinatRegion = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
        mapView.addAnnotation(MapAnnotation(fromStation: station))
        mapView.setRegion(mapView.regionThatFits(coordinatRegion), animated: true)

        let stationVC = StationViewController()
        bottomSheet.invalidateNotchHeights()
        notchPercentages = [0, 0.87]
        bottomSheet.viewControllers = [stationVC]
        addChild(bottomSheet, in: view)
        bottomSheet.moveOverlay(toNotchAt: 1, animated: true)
    }
}
