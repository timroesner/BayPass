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
    var agency: Agency
    var destination: String
    var color: UIColor
    var transitMode: TransitMode

    init(name: String, agency: Agency, destination: String, color: UIColor, transitMode: TransitMode) {
        self.name = name
        self.agency = agency
        self.destination = destination
        self.color = color
        self.transitMode = transitMode
    }
}
