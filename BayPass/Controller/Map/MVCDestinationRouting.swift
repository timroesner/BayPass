//
//  MVCDestinationRouting.swift
//  BayPass
//
//  Created by Tim Roesner on 3/2/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import MapKit
import OverlayContainer
import SnapKit
import UIKit

extension MapViewController: UIScrollViewDelegate {
    func displayRoute(from: MKMapItem? = nil, to destination: MKMapItem) {
        startItem = from
        endItem = destination

        var startLocation: CLLocationCoordinate2D
        if let fromItem = from {
            startLocation = fromItem.placemark.coordinate
        } else {
            if ProcessInfo.processInfo.arguments.contains("UITests") {
                startLocation = CLLocationCoordinate2D(latitude: 37.331348, longitude: -121.888877)
            } else {
                guard let realUserLocation = locationManager.location?.coordinate else {
                    displayAlert(title: "User Location unknown", msg: "Please allow BayPass to access your current location, to plan a route to this destination.", dismissAfter: false)
                    return
                }
                startLocation = realUserLocation
            }
        }

        bottomSheet.moveOverlay(toNotchAt: 0, animated: true)
        removeChild(bottomSheet)

        for view in view.subviews {
            if view is UIScrollView || view is SearchFloatView {
                view.removeFromSuperview()
            }
        }
        mapView.removeAnnotations(mapView.annotations)
        mapView.removeOverlays(mapView.overlays)

        let searchFloat = SearchFloatView(from: from?.name ?? "Current Location", to: destination.name ?? "No Name")
        searchFloat.fromTextField.delegate = self
        searchFloat.fromTextField.addTarget(self, action: #selector(searchTextFieldChanged(_:)), for: .editingChanged)
        searchFloat.toTextField.delegate = self
        searchFloat.toTextField.addTarget(self, action: #selector(searchTextFieldChanged(_:)), for: .editingChanged)
        view.addSubview(searchFloat)
        searchFloat.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(12)
            make.right.left.equalToSuperview().inset(12)
        }
        searchFloat.cancelButton.addTarget(self, action: #selector(cancelRouting), for: .touchUpInside)

        GoogleMaps().getRoutes(from: startLocation, to: destination.placemark.coordinate) { routes in
            self.setupRoutesView(with: routes)
        }
        showLimeScootersOnMap(at: startLocation)
        showLimeScootersOnMap(at: destination.placemark.coordinate)
        showBirdScootersOnMap(at: destination.placemark.coordinate, radius: 500)
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
            routeOverview.isUserInteractionEnabled = true
            let swipeGesture = UITapGestureRecognizer(target: self, action: #selector(tapRoute(_:)))
            routeOverview.addGestureRecognizer(swipeGesture)
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
        if routes.isEmpty {
            let emptyView = EmptyView(text: "Could not find any transit routes")
            emptyView.layer.cornerRadius = 14
            emptyView.layer.backgroundColor = UIColor.white.cgColor
            scrollView.addSubview(emptyView)
            emptyView.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(4)
                make.height.equalTo(122)
                make.width.equalTo(view.frame.width - 40)
                make.left.equalToSuperview()
            }
        } else {
            let width = (view.frame.width - 32) * CGFloat(routes.count)
            scrollView.contentSize = CGSize(width: width, height: 130)
        }
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

    @objc func tapRoute(_ recognizer: UITapGestureRecognizer) {
        let routeView = recognizer.view as? RouteOverView
        let routeDetailsVC = RouteDetailsViewController()
        routeDetailsVC.route = routeView?.route
        routeDetailsVC.routeOverView = RouteOverView(with: routeView!.route)
        routeDetailsVC.parentSheet = bottomSheet
        bottomSheet.invalidateNotchHeights()
        notchPercentages = [0, 0.87]
        bottomSheet.viewControllers = [routeDetailsVC]
        addChild(bottomSheet, in: view)
        bottomSheet.drivingScrollView = routeDetailsVC.scrollView
        bottomSheet.moveOverlay(toNotchAt: 1, animated: true)
    }

    @objc func cancelRouting() {
        for view in view.subviews {
            if view is SearchFloatView || view is UIScrollView {
                view.removeFromSuperview()
            }
        }
        mapView.removeOverlays(mapView.overlays)
        mapView.removeAnnotations(mapView.annotations)
        routes.removeAll()
        centerOnUserLocation()
        setupSearchView()
        addChild(bottomSheet, in: view)
    }
}
