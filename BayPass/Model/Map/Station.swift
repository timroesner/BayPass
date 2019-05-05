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
    var timings: [String]

    init(name: String, code: Int, transitModes: [TransitMode], lines: [Line], location: CLLocation, timings: [String]) {
        self.name = name
        self.code = code
        self.transitModes = transitModes
        self.lines = lines
        self.location = location
        self.timings = timings
    }

    func getPrimaryTransitMode() -> TransitMode {
        if transitModes.contains(.calTrain) {
            return .calTrain
        } else if transitModes.contains(.bart) {
            return .bart
        } else if transitModes.contains(.lightRail) {
            return .lightRail
        } else {
            return .bus
        }
    }

    func getColor() -> UIColor {
        switch getPrimaryTransitMode() {
        case .calTrain:
            return #colorLiteral(red: 0.8500424027, green: 0.2757331729, blue: 0.2237280607, alpha: 1)
        case .bart:
            return #colorLiteral(red: 0.2190811634, green: 0.5006315708, blue: 0.7984559536, alpha: 1)
        case .lightRail:
            return #colorLiteral(red: 0.2022112012, green: 0.5027229786, blue: 0.6945596933, alpha: 1)
        case .bus:
            return #colorLiteral(red: 0.2284308672, green: 0.5924664736, blue: 0.8979970217, alpha: 1)
        }
    }

    func getIcon() -> UIImage {
        switch getPrimaryTransitMode() {
        case .calTrain:
            return #imageLiteral(resourceName: "CalTrain")
        case .bart:
            return #imageLiteral(resourceName: "BART")
        case .lightRail:
            return #imageLiteral(resourceName: "Tram")
        case .bus:
            return #imageLiteral(resourceName: "Bus")
        }
    }
}
