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

    // Only used for the MapAnnotation
    var color = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)

    init(name: String, code: Int, transitModes: [TransitMode], lines: [String], location: CLLocation) {
        self.name = name
        self.code = code
        self.transitModes = transitModes
        self.lines = lines
        self.location = location
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
