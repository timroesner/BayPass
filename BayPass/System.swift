//
//  System.swift
//  BayPass
//
//  Created by Ayesha Khan on 3/28/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import Foundation
import MapKit

class System {
    var here = Here.shared
    var allStationsDict = [String: Station]()
    var allStations = [Station]()
    var allLines = [String: Line]()
    private var coordinates = [Coordinates]()

    func getAllStations() {
        coordinates = getAllCoordinates()
        let group = DispatchGroup()

        for c in coordinates {
            group.enter()
            here.getStationsNearby(center: c.center, radius: c.radius, max: c.max) { stations in
                for station in stations {
                    if var stationThatsAlreadyThere = self.allStationsDict[station.name] {
                        stationThatsAlreadyThere.lines.append(contentsOf: station.lines)
                    } else {
                        self.allStationsDict[station.name] = station
                    }
                    for line in station.lines {
                        self.allLines[line.name+" - "+line.destination] = line
                    }
                }
                group.leave()
            }
        }
        group.notify(queue: .main) {
            self.allStations.append(contentsOf: self.allStationsDict.values)
        }
    }

    func findStations(with query: String) -> [Station] {
        return allStations.filter { $0.name.lowercased().contains(query.lowercased()) }
    }
}
