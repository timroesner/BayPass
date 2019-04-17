//
//  File.swift
//  BayPass
//
//  Created by Tim Roesner on 2/28/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import MapKit
import UIKit

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection _: Int) -> Int {
        if searchResults.isEmpty {
            tableView.backgroundView = EmptyView(text: "Nothing to see here")
        } else {
            tableView.backgroundView = nil
        }
        return searchResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let resultObject = searchResults[indexPath.row]

        if let station = resultObject as? Station {
            let cell = tableView.dequeueReusableCell(withIdentifier: stationCellId, for: indexPath) as! StationSearchResultTableViewCell
            cell.setup(with: station)
            return cell
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
        resetSearch()
    }

    func scrollViewDidScroll(_: UIScrollView) {
        searchBarSearchButtonClicked(searchBar)
    }
}
