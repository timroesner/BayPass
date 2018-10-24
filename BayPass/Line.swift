//
//  Line.swift
//  BayPass
//
//  Created by Ayesha Khan on 10/20/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

import UIKit

struct Line {
    var name: String
    var code: Int
    var destination: String
    var stops: [Station]
    var transitMode: TransitMode

    func getStops() -> [Station] {
        // TODO: Implement here
        return [Station(name: " ", code: 0, transitModes: [TransitMode.bart], lines: [self])]
    }
}
