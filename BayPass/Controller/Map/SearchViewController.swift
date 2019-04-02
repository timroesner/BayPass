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
    let sys = System()
    var allStationsDict = [String: Station]()

    let stationCellId = "station"
    let destinationCellId = "destination"

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.register(DestinationSearchResultTableViewCell.self, forCellReuseIdentifier: destinationCellId)
        tableView.register(StationSearchResultTableViewCell.self, forCellReuseIdentifier: stationCellId)
        sys.getAllStations { resp -> Void in
            self.allStationsDict = resp
            print(self.allStationsDict.keys)
        }

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
        print(allStationsDict.keys)
        if let (name, station) = allStationsDict.first(where: { (key, _) -> Bool in key.contains(searchText) }) {
            print(name)
            searchResults.append(station)
            sortResults()
            searchDestinations(with: searchText)
            tableView.reloadData()
        } else {
            print("no match")
            searchDestinations(with: searchText)
        }
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
            self.sortResults()
//            self.tableView.reloadData()
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

            var secoondLocation = CLLocation()
            if let station = second as? Station {
                secoondLocation = station.location
            } else if let destination = second as? MKMapItem {
                secoondLocation = destination.placemark.location ?? CLLocation()
            }

            let userLocation = parentMapVC?.mapView.userLocation.location ?? CLLocation()
            return firstLocation.distance(from: userLocation) < secoondLocation.distance(from: userLocation)
        }
    }
}
