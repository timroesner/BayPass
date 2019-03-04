//
//  SVCSearchBar.swift
//  BayPass
//
//  Created by Tim Roesner on 2/28/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import UIKit

extension SearchViewController: UISearchBarDelegate {
    
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
        resetSearch()
        delegate?.keyboardWillHide()
    }
    
    func resetSearch() {
        searchBar.text = nil
        searchResults = []
        tableView.reloadData()
    }
}
