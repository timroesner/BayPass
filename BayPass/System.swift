//
//  System.swift
//  BayPass
//
//  Created by Ayesha Khan on 3/28/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import Foundation
import MapKit

struct Coordinates {
    var center: CLLocationCoordinate2D
    var radius: Int
    var max: Int
    var time: String

    init(center: CLLocationCoordinate2D, radius: Int, max: Int, time: String) {
        self.center = center
        self.radius = radius
        self.max = max
        self.time = time
    }
}

class System {
    let group = DispatchGroup()
    var here = Here.shared
    var allStationsDict = [String: Station]()
    var allStations = [Station]()
    var allLines = [String: Line]()
    private var coordinates = [Coordinates]()

    func getAllStations() {
        let c1 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.309690, longitude: -121.940223), radius: 1500, max: 50, time: "2019-03-24T01:23:45")
        let c2 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.338489, longitude: -121.945763), radius: 1500, max: 50, time: "2019-03-24T01:23:45")
        let c3 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.320425, longitude: -121.907463), radius: 1500, max: 50, time: "2019-03-24T01:23:45")
        let c4 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.341991, longitude: -121.877350), radius: 1500, max: 50, time: "2019-03-24T01:23:45")
        let c5 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.311733, longitude: -121.874423), radius: 1500, max: 50, time: "2019-03-24T01:23:45")
        let c6 = Coordinates(center: CLLocationCoordinate2D(latitude: 37.692235, longitude: -122.462882), radius: 1500, max: 50, time: "2019-03-24T01:23:45")

        coordinates.append(c1)
        coordinates.append(c2)
        coordinates.append(c3)
        coordinates.append(c4)
        coordinates.append(c5)
        coordinates.append(c6)

        for c in coordinates {
            group.enter()
            here.getStationsNearby(center: c.center, radius: c.radius, max: c.max, time: c.time) { stations in
                for station in stations {
                    if var stationThatsAlreadyThere = self.allStationsDict[station.name] {
                        stationThatsAlreadyThere.lines.append(contentsOf: station.lines)
                    } else {
                        self.allStationsDict[station.name] = station
                    }
                    for line in station.lines {
                        self.allLines[line.name + "-" + line.agency.stringValue] = line
                    }
                }
                self.group.leave()
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
