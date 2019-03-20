//
//  ViewController.swift
//  BayPass
//
//  Created by Tim Roesner on 9/14/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

import CoreLocation
import MapKit
import OverlayContainer
import SnapKit
import UIKit

class MapViewController: UIViewController {
    private(set) var mapView = MKMapView()
    let bottomSheet = OverlayContainerViewController(style: .rigid)
    let searchVC = SearchViewController()
    var locationManager = CLLocationManager()
    var notchPercentages = [CGFloat]()

    // Route Search properties
    var startIndex = 0
    var routes = [Route]()

    override func viewDidLoad() {
        super.viewDidLoad()

        GoogleFirestore.shared.read()

        NotificationCenter.default.addObserver(self, selector: #selector(centerOnUserLocation), name: .willEnterForeground, object: nil)

        setupViews()
        setupLocation()
    }

    func setupViews() {
        mapView.showsUserLocation = true
        mapView.delegate = self
        mapView.register(MarkerView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        centerOnUserLocation()
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.top.bottom.right.left.equalToSuperview()
        }

        let blurredStatusBar = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        view.addSubview(blurredStatusBar)
        blurredStatusBar.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }

        bottomSheet.delegate = self
        searchVC.delegate = self
        searchVC.parentMapVC = self
        setupSearchView()
        addChild(bottomSheet, in: view)
    }
}
