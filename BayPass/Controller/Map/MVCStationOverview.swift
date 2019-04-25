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
        let coordinateUpper = mapView.moveCenterByOffSet(offSet: CGPoint(x: 0, y: 150), coordinate: coordinate)
        let coordinatRegion = MKCoordinateRegion(center: coordinateUpper, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
        mapView.addAnnotation(MapAnnotation(fromStation: station))

        mapView.setRegion(mapView.regionThatFits(coordinatRegion), animated: true)
        stationVC.station = station
        bottomSheet.invalidateNotchHeights()
        notchPercentages = [0.2, 0.5, 0.95]
        bottomSheet.viewControllers = [stationVC]
        addChild(bottomSheet, in: view)
        bottomSheet.moveOverlay(toNotchAt: 1, animated: true)
    }
}
