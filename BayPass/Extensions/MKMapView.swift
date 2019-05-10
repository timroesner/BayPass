//
//  MKMapView.swift
//  BayPass
//
//  Created by Ayesha Khan on 4/25/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import MapKit

extension MKMapView {
    func moveCenterByOffSet(offSet: CGPoint, coordinate: CLLocationCoordinate2D) -> CLLocationCoordinate2D {
        var point = convert(coordinate, toPointTo: self)

        point.x += offSet.x
        point.y += offSet.y

        let center = convert(point, toCoordinateFrom: self)
        setCenter(center, animated: true)
        return convert(point, toCoordinateFrom: self)
    }
}
