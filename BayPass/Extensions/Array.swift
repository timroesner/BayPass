//
//  Array.swift
//  BayPass
//
//  Created by Ayesha Khan on 4/4/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import Foundation

extension Array {
    func filterDuplicate<T>(_ keyValue: (Element) -> T) -> [Element] {
        var uniqueKeys = Set<String>()
        return filter { uniqueKeys.insert("\(keyValue($0))").inserted }
    }
}
