//
//  MVCTextFieldDelegate.swift
//  BayPass
//
//  Created by Tim Roesner on 5/8/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import UIKit
import MapKit

extension MapViewController: UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        destinations.removeAll()
        destinationsTableView.reloadData()
        changingFrom = textField.placeholder == "Location"
        view.addSubview(destinationsTableView)
        destinationsTableView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().inset(keyboardHeight)
            make.left.right.equalToSuperview()
            make.height.equalTo(150)
        }
    }
    
    @objc func searchTextFieldChanged(_ textField: UITextField) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = textField.text
        
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
            print(self.destinations)
            self.destinationsTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return destinations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: destinationCellId, for: indexPath) as! DestinationSearchResultTableViewCell
        cell.setup(with: destinations[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        destinationsTableView.removeFromSuperview()
        tableView.deselectRow(at: indexPath, animated: true)
        if changingFrom {
            displayRoute(from: destinations[indexPath.row], to: endItem)
        } else {
            displayRoute(from: startItem, to: destinations[indexPath.row])
        }
        view.endEditing(true)
    }
}
