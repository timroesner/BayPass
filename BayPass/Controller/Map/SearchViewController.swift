//
//  SearchViewController.swift
//  BayPass
//
//  Created by Tim Roesner on 2/28/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import CoreLocation
import MapKit
import SnapKit
import UIKit

class SearchViewController: UIViewController {
    private(set) var searchBar = UISearchBar()
    private(set) var tableView = UITableView()
    var delegate: SearchViewControllerDelegate?
    private var destinations = [MKMapItem]()
    private var stations = [Station]()
    var searchResults = [Any]()
    var parentMapVC: MapViewController?

    let stationCellId = "station"
    let destinationCellId = "destination"
    let subject = Station(name: "Test", code: 2, transitModes: [TransitMode.bart], lines: [Line(name: "m", agency: Agency.ACE, destination: "n", color: #colorLiteral(red: 0.2901960784, green: 0.5647058824, blue: 0.8862745098, alpha: 1), transitMode: TransitMode.bart)], location: CLLocation(latitude: 0.0, longitude: 0.0))
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.register(DestinationSearchResultTableViewCell.self, forCellReuseIdentifier: destinationCellId)
        tableView.register(StationSearchResultTableViewCell.self, forCellReuseIdentifier: stationCellId)
        tableView.estimatedRowHeight = 57.0

        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 21
        setupViews()
    }

    func setupViews() {
        let moveIndicator = MoveIndicator()
        view.addSubview(moveIndicator)
        moveIndicator.setConstraints()

        searchBar.placeholder = "Search"
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = self
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(moveIndicator.snp.bottom).offset(-2)
            make.right.left.equalToSuperview().inset(8)
        }

        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(8)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

    func searchStations(with searchText: String) {
        stations = transitSystem.findStations(with: searchText)
        searchResults = []
        searchResults.append(contentsOf: destinations)
        searchResults.append(contentsOf: stations)
        sortResults()
        tableView.reloadData()
    }

    func searchDestinations(with searchText: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText

        let center = CLLocationCoordinate2D(latitude: 37.543233, longitude: -122.091734)
        let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 2)
        request.region = MKCoordinateRegion(center: center, span: span)

        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard let response = response else {
                print(error?.localizedDescription as Any)
                return
            }
            self.destinations = response.mapItems
            self.searchResults = []
            self.searchResults.append(contentsOf: self.destinations)
            self.searchResults.append(contentsOf: self.stations)
            self.sortResults()
            self.tableView.reloadData()
        }
    }

    func sortResults() {
        searchResults.sort { (first, second) -> Bool in
            var firstLocation = CLLocation()
            if let station = first as? Station {
                firstLocation = station.location
            } else if let destination = first as? MKMapItem {
                firstLocation = destination.placemark.location ?? CLLocation()
            }

            var secondLocation = CLLocation()
            if let station = second as? Station {
                secondLocation = station.location
            } else if let destination = second as? MKMapItem {
                secondLocation = destination.placemark.location ?? CLLocation()
            }

            let userLocation = parentMapVC?.mapView.userLocation.location ?? CLLocation()
            return firstLocation.distance(from: userLocation) < secondLocation.distance(from: userLocation)
        }
    }
}
