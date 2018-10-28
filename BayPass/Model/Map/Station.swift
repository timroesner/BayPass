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
    var transitModes: [TransitMode] = [TransitMode.bart]
    var lines: [Line]
    var location: CLLocation = CLLocation()

    init(name: String, code: Int, transitModes: [TransitMode], lines: [Line], location: CLLocation) {
        self.name = name
        self.code = code
        self.transitModes = transitModes
        self.lines = lines
        self.location = location
    }

    func getDepartureTimes() -> [Int] {
        // TODO: Implement here
        fatalError("Not implemented yet")
        return []
    }

    func getPrimaryTransitMode() -> TransitMode {
        // TODO: Implement here
        fatalError("Not implemented yet")
        return TransitMode.calTrain
    }
}
