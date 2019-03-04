//
//  File.swift
//  BayPass
//
//  Created by Tim Roesner on 2/28/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import UIKit
import MapKit

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchResults.isEmpty {
            tableView.backgroundView = EmptyView(text: "Nothing to see here")
        } else {
            tableView.backgroundView =  nil
        }
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let resultObject = searchResults[indexPath.row]
        
        if let station = resultObject as? Station {
            //cell = tableView.dequeueReusableCell(withIdentifier: <#T##String#>, for: indexPath)
        }
        
        if let destination = resultObject as? MKMapItem {
            let cell = tableView.dequeueReusableCell(withIdentifier: destinationCellId, for: indexPath) as! DestinationSearchResultTableViewCell
            cell.setup(with: destination)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didSelectSearchResult(searchResults[indexPath.row])
    }
}
