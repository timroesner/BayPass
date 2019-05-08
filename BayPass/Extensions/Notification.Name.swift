//
//  Notification.Name.swift
//  BayPass
//
//  Created by Tim Roesner on 3/13/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import Foundation

extension Notification.Name {
    static var willEnterForeground: Notification.Name {
        return .init(rawValue: "willEnterForeground")
    }
    
    static var didUpdatePrice: Notification.Name {
        return .init(rawValue: "didUpdatePrice")
    }
}
