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
    var name: String
    var code: Int
    var transitModes: [TransitMode]
    var lines: [Line]
    var location: CLLocation

    func getDepartureTimes() -> [Int] { return [] }
    func getPrimaryTransitMode() -> TransitMode {
        return TransitMode.calTrain
    }
}
