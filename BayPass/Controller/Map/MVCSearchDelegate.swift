//
//  MVCSearchDelegate.swift
//  BayPass
//
//  Created by Tim Roesner on 2/28/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import Foundation

extension MapViewController: SearchViewControllerDelegate {
    
    func keyboardWillShow() {
        bottomSheet.moveOverlay(toNotchAt: 1, animated: true)
    }
    
    func keyboardWillHide() {
        bottomSheet.moveOverlay(toNotchAt: 0, animated: true)
    }
    
    func didSelectSearchResult(_ result: Any) {
    }
    
}
