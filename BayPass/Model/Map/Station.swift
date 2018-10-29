//
//  Station.swift
//  BayPass
//
//  Created by Ayesha Khan on 10/20/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

import CoreLocation
import UIKit

struct Station: Equatable {
    var name: String
    var code: Int
    var transitModes: [TransitMode]
    var lines: [String]
    var location: CLLocation

    init(name: String, code: Int, transitModes: [TransitMode], lines: [String], location: CLLocation) {
        self.name = name
        self.code = code
        self.transitModes = transitModes
        self.lines = lines
        self.location = location
    }

    func getDepartureTimes() -> [Int] {
        // TODO: Implement here
        fatalError("getDepartureTimes() is not implemented yet")
    }

    func getPrimaryTransitMode() -> [TransitMode] {
        // TODO: Implement here
        fatalError("gerPrimaryTransitMode is not implemented yet")
    }
}
