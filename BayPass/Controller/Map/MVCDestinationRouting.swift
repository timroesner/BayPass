//
//  MVCDestinationRouting.swift
//  BayPass
//
//  Created by Tim Roesner on 3/2/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import UIKit
import MapKit
import SnapKit

extension MapViewController: UIScrollViewDelegate {
    
    func displayRoute(to destination: MKMapItem) {
        guard let userLocation = locationManager.location?.coordinate else {
            displayAlert(title: "User Location unknown", msg: "Please allow BayPass to access your current location, to plan a route to this destination.", dismissAfter: false)
            return
        }
        
        bottomSheet.moveOverlay(toNotchAt: 0, animated: true)
        removeChild(bottomSheet)
        
        let searchFloat = SearchFloatView(from: "Current Location", to: destination.name ?? "No Name")
        view.addSubview(searchFloat)
        searchFloat.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(12)
            make.right.left.equalToSuperview().inset(12)
        }
        searchFloat.cancelButton.addTarget(self, action: #selector(cancelRouting), for: .touchUpInside)
        
        GoogleMaps().getRoutes(from: userLocation, to: destination.placemark.coordinate) { (routes) in
            self.setupRoutesView(with: routes)
        }
    }
    
    func setupRoutesView(with routes: [Route]) {
        let scrollView = UIScrollView()

        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.clipsToBounds = false
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.equalToSuperview().inset(20)
            make.right.equalToSuperview().inset(12)
            make.height.equalTo(130)
        }

        var routeViews = [UIView]()
        for route in routes {
            let canvas = UIView()
            canvas.layer.backgroundColor = UIColor.white.cgColor
            canvas.layer.cornerRadius = 14
            scrollView.addSubview(canvas)
            canvas.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(4)
                make.height.equalTo(122)
                make.width.equalTo(view.frame.width-40)
                if let previous = routeViews.last {
                    make.left.equalTo(previous.snp.right).offset(8)
                }
            }
            routeViews.append(canvas)
        }
        let width = view.frame.width * CGFloat(routes.count)
        scrollView.contentSize = CGSize(width: width, height: 130)
    }
    
    @objc func cancelRouting() {
        for view in view.subviews {
            if view is SearchFloatView || view is UIScrollView {
                view.removeFromSuperview()
            }
        }
        setupSearchView()
        addChild(bottomSheet, in: view)
    }
}
