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

    init(name: String, code: Int, destination: String, stops: [Station]) {
        self.name = name
        self.code = code
        self.destination = destination
        self.stops = stops
    }

    func getStops() -> [Station] {
        return stops
    }
}
