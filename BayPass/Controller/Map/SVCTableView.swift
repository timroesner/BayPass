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
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let resultObject = searchResults[indexPath.row]
        var cell = UITableViewCell()
        
        if let station = resultObject as? Station {
            cell = tableView.dequeueReusableCell(withIdentifier: <#T##String#>, for: indexPath)
        }
        
        if let destination = resultObject as? MKMapItem {
            
        }
        return cell
    }
    
    
}
