//
//  Station.swift
//  BayPass
//
//  Created by Ayesha Khan on 10/20/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

import CoreLocation
import UIKit

struct Station {
    var name: String = ""
    var code: Int = 0
    var transitModes: [TransitMode]
    var lines: [Line]
    var location = CLLocation()

    init(name: String, code: Int, transitModes: [TransitMode], lines: [Line]) {
        self.name = name
        self.code = code
        self.transitModes = transitModes
        self.lines = lines
    }

    func getDepartureTimes() -> [Int] {
        // TODO: Implement here
        return [0]
    }

    func getPrimaryTransitMode() -> [TransitMode] {
        // TODO: Implement here
        return transitModes
    }
}
