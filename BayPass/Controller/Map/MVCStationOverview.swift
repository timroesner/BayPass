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
        mapView.removeAnnotations(mapView.annotations)

        let coordinate = CLLocationCoordinate2D(latitude: station.location.coordinate.latitude, longitude: station.location.coordinate.longitude)
        let mapEdgePadding = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)

        let coordinatRegion = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
        mapView.addAnnotation(MapAnnotation(fromStation: station))

//        mapView.setRegion(mapView.regionThatFits(coordinatRegion), animated: true)
//        mapView.setVisibleMapRect(coordinatRegion, edgePadding: mapEdgePadding, animated: true)
        stationVC.station = station
        stationVC.cancelLabel.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        stationVC.cancelLabel.addGestureRecognizer(tap)
        bottomSheet.invalidateNotchHeights()
        notchPercentages = [0.175, 0.5, 0.95]
        bottomSheet.viewControllers = [stationVC]
        addChild(bottomSheet, in: view)
        bottomSheet.moveOverlay(toNotchAt: 1, animated: true)
    }

    @objc func tapFunction(sender _: UITapGestureRecognizer) {
        mapView.removeAnnotations(mapView.annotations)
        centerOnUserLocation()
        setupSearchView()
    }
}
