//
//  ViewController.swift
//  BayPass
//
//  Created by Tim Roesner on 9/14/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

import CoreLocation
import MapKit
import SnapKit
import UIKit

class MapViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let tableView = UITableView()
    var destinations = [MKMapItem]()
    let cellIdentifier = "destination"

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return destinations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! DestinationSearchResultTableViewCell
        cell.setup(with: destinations[indexPath.row])
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addLabel(title: "Map")

        tableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 250)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DestinationSearchResultTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        view.addSubview(tableView)
        search(with: "Santa")
    }

    func search(with query: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query

        let center = CLLocationCoordinate2D(latitude: 37.543233, longitude: -122.091734)
        let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 2)
        request.region = MKCoordinateRegion(center: center, span: span)

        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            if let response = response {
                self.destinations = response.mapItems
                self.tableView.reloadData()
            }
        }
    }
}
