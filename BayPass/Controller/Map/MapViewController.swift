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
    var startItem: MKMapItem?
    var endItem = MKMapItem()
    var destinations = [MKMapItem]()
    let destinationsTableView = UITableView()
    let destinationCellId = "destinationCell"
    var keyboardHeight: CGFloat = 0.0
    var changingFrom = false

    // Route Search properties
    var startIndex = 0
    var routes = [Route]()

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(centerOnUserLocation), name: .willEnterForeground, object: nil)
        setupViews()
        setupLocation()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(centerOnUserLocation), name: .willEnterForeground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: .willEnterForeground, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
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

        destinationsTableView.delegate = self
        destinationsTableView.dataSource = self
        destinationsTableView.register(DestinationSearchResultTableViewCell.self, forCellReuseIdentifier: destinationCellId)

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

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeight = keyboardSize.height
        }
    }
}
