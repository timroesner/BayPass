//
//  String.swift
//  BayPass
//
//  Created by Tim Roesner on 10/25/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
