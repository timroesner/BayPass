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

    func getIcon() -> UIImage {
        switch transitMode {
        case .bart:
            return #imageLiteral(resourceName: "BART")
        case .bus:
            return #imageLiteral(resourceName: "Bus")
        case .calTrain:
            return #imageLiteral(resourceName: "CalTrain")
        case .lightRail:
            return #imageLiteral(resourceName: "Tram")
        default:
            return #imageLiteral(resourceName: "Tram")
        }
    }
}
