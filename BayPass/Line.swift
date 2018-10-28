//
//  Line.swift
//  BayPass
//
//  Created by Ayesha Khan on 10/20/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

import UIKit

struct Line {
    var name: String = ""
    var code: Int = 0
    var destination: String = ""
    var stops: [Station] // { get } swift should automatically do that
    var transitMode: TransitMode

    init(name: String, code: Int, destination: String, stops: [Station], transitMode: TransitMode) {
        self.name = name
        self.code = code
        self.destination = destination
        self.stops = stops
        self.transitMode = transitMode
    }

    func getStops() -> [Station] {
        // TODO: Implement here
        return stops
    }
}
