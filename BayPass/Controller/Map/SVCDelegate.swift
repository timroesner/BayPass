//
//  SearchDelegate.swift
//  BayPass
//
//  Created by Tim Roesner on 2/28/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import Foundation

public protocol SearchViewControllerDelegate {
    func keyboardWillShow()
    func keyboardWillHide()
    func didSelectSearchResult(_ result: Any)
}
