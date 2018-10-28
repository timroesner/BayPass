//
//  Collection.swift
//  BayPass
//
//  Created by Tim Roesner on 10/25/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
