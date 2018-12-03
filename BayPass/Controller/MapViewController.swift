//
//  ViewController.swift
//  BayPass
//
//  Created by Tim Roesner on 9/14/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

import CoreLocation
import UIKit

class MapViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addLabel(title: "Map")

        Bird().getScooters(fromLocation: CLLocation(latitude: 48.858635, longitude: 2.298493), radius: 1000) { result in
            print(result)
        }
    }
}
