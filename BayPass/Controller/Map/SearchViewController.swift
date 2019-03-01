//
//  SearchViewController.swift
//  BayPass
//
//  Created by Tim Roesner on 2/28/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import UIKit
import SnapKit
import MapKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    private var searchBar = UISearchBar()
    private var tableView = UITableView()
    var delegate: SearchViewControllerDelegate?
    private var destinations = [MKMapItem]()
    private var stations = [Station]()
    private(set) var searchResults = [Any]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
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
        searchBar.snp.makeConstraints { (make) in
            make.top.equalTo(moveIndicator.snp.bottom).offset(-2)
            make.right.left.equalToSuperview().inset(8)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchDestinations(with: searchText)
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        delegate?.keyboardWillShow()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
        delegate?.keyboardWillHide()
    }
    
    func searchDestinations(with searchText: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        
        let center = CLLocationCoordinate2D(latitude: 37.543233, longitude: -122.091734)
        let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 2)
        request.region = MKCoordinateRegion(center: center, span: span)
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            guard let response = response else {
                print(error?.localizedDescription as Any)
                return
            }
            
            self.destinations = response.mapItems
            self.tableView.reloadData()
        }
    }
}
