//
//  ViewController.swift
//  BayPass
//
//  Created by Tim Roesner on 9/14/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

import CoreLocation
import SnapKit
import MapKit
import OverlayContainer
import UIKit

class MapViewController: UIViewController, OverlayContainerViewControllerDelegate {
    private var mapView = MKMapView()
    let bottomSheet = OverlayContainerViewController()
    let searchVC = SearchViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        view.addSubview(mapView)
        mapView.snp.makeConstraints { (make) in
            make.top.bottom.right.left.equalToSuperview()
        }
        
        let blurredStatusBar = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        view.addSubview(blurredStatusBar)
        blurredStatusBar.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        bottomSheet.delegate = self
        searchVC.delegate = self
        bottomSheet.viewControllers = [searchVC]
        addChild(bottomSheet, in: view)
    }
    
    func numberOfNotches(in containerViewController: OverlayContainerViewController) -> Int {
        return 2
    }
    
    func overlayContainerViewController(_ containerViewController: OverlayContainerViewController, heightForNotchAt index: Int, availableSpace: CGFloat) -> CGFloat {
        switch index {
        case 0:
            return availableSpace * 0.20
        case 1:
            return availableSpace * 0.95
        default:
            return 0
        }
    }
}
