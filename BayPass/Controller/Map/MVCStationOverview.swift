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

        mapView.addAnnotation(MapAnnotation(fromStation: station))
        let insets = UIEdgeInsets(top: 0, left: view.frame.width/2, bottom: 0, right: 0)
        let rect = MKMapRect(origin: MKMapPoint(station.location.coordinate), size: MKMapSize(width: 3000, height: 3000))
        mapView.setVisibleMapRect(rect, edgePadding: insets, animated: true)
        
        let stationVC = StationViewController(station: station)
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        stationVC.cancelView.addGestureRecognizer(tap)
        stationVC.parentMapVC = self
        bottomSheet.invalidateNotchHeights()
        notchPercentages = [0.19, 0.5, 0.95]
        bottomSheet.viewControllers = [stationVC]
        bottomSheet.drivingScrollView = stationVC.lineTableView
        bottomSheet.moveOverlay(toNotchAt: 1, animated: true)
    }

    @objc func tapFunction(sender _: UITapGestureRecognizer) {
        mapView.removeAnnotations(mapView.annotations)
        centerOnUserLocation()
        setupSearchView()
    }
}
