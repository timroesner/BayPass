//
//  MVCDestinationRouting.swift
//  BayPass
//
//  Created by Tim Roesner on 3/2/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import MapKit
import SnapKit
import UIKit

extension MapViewController: UIScrollViewDelegate {
    func displayRoute(to destination: MKMapItem) {
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

        let searchFloat = SearchFloatView(from: "Current Location", to: destination.name ?? "No Name")
        view.addSubview(searchFloat)
        searchFloat.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(12)
            make.right.left.equalToSuperview().inset(12)
        }
        searchFloat.cancelButton.addTarget(self, action: #selector(cancelRouting), for: .touchUpInside)

        GoogleMaps().getRoutes(from: userLocation, to: destination.placemark.coordinate) { routes in
            self.setupRoutesView(with: routes)
        }
    }

    func setupRoutesView(with routes: [Route]) {
        self.routes = routes
        let scrollView = UIScrollView()

        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.clipsToBounds = false
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.equalToSuperview().inset(20)
            make.right.equalToSuperview().inset(12)
            make.height.equalTo(130)
        }

        var routeViews = [UIView]()
        for route in routes {
            let routeOverview = RouteOverView(with: route)
            scrollView.addSubview(routeOverview)
            routeOverview.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(4)
                make.height.equalTo(122)
                make.width.equalTo(view.frame.width - 40)
                if let previous = routeViews.last {
                    make.left.equalTo(previous.snp.right).offset(8)
                } else {
                    renderPolylines(for: route)
                    make.left.equalToSuperview()
                }
            }
            routeViews.append(routeOverview)
        }
        let width = (view.frame.width - 32) * CGFloat(routes.count)
        scrollView.contentSize = CGSize(width: width, height: 130)
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startIndex = Int(scrollView.contentOffset.x / (view.frame.width - 40))
    }

    func scrollViewWillEndDragging(_: UIScrollView, withVelocity _: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let targetX = targetContentOffset.pointee.x
        let index = Int(targetX / (view.frame.width - 40))
        didChangeToRoute(at: index)
    }

    func didChangeToRoute(at index: Int) {
        if index != startIndex {
            let route = routes[index]
            mapView.removeOverlays(routes[startIndex].getPolylines())
            renderPolylines(for: route)
        }
    }

    func renderPolylines(for route: Route) {
        mapView.addOverlays(route.getPolylines())
        if let boundingRect = route.getBoundingMapRect() {
            mapView.setVisibleMapRect(boundingRect, edgePadding: UIEdgeInsets(top: 140, left: 10, bottom: 140, right: 10), animated: true)
        }
    }

    @objc func cancelRouting() {
        for view in view.subviews {
            if view is SearchFloatView || view is UIScrollView {
                view.removeFromSuperview()
            }
        }
        mapView.removeOverlays(mapView.overlays)
        centerOnUserLocation()
        setupSearchView()
        addChild(bottomSheet, in: view)
    }
}
