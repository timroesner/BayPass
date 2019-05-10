//
//  Here.swift
//  BayPass
//
//  Created by Ayesha Khan on 2/27/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import Alamofire
import Foundation
import MapKit

class Here {
    static let shared = Here()
    private init() {}

    // MARK: Get Requests for Here
    func getStationsNearby(center: CLLocationCoordinate2D, radius: Int, max: Int, completion: @escaping ([Station]) -> Void) {
        let param = [
            "center": "\(center.latitude),\(center.longitude)",
            "radius": radius,
            "app_id": Credentials().hereAppID,
            "app_code": Credentials().hereAppCode,
            "max": max,
        ] as [String: Any]

        var stations = [Station]()
        Alamofire.request("https://transit.api.here.com/v3/stations/by_geocoord.json?", method: .get, parameters: param).responseJSON { resp in
            if let json = resp.result.value as? [String: Any],
                let resJson = json["Res"] as? [String: Any],
                let stationsJson = resJson["Stations"] as? [String: Any],
                let stnsJson = stationsJson["Stn"] as? [[String: Any]] {
                for stnJson in stnsJson {
                    if let newStation = self.parseStation(from: stnJson) {
                        stations.append(newStation)
                    }
                }
                completion(stations)
            } else {
                print("Failed in getting Stations near \(center)")
                completion([])
            }
        }
    }

    func getDepartureTimesForAStation(stationId: Int, completion: @escaping ([(line: Line, departureTimes: [Date])]) -> Void) {
        let param = [
            "app_id": Credentials().hereAppID,
            "app_code": Credentials().hereAppCode,
            "lang": "en",
            "stnId": stationId,
            "time": Date().getCurrentTimetoFormattedStringForHereAPI(),
        ] as [String: Any]

        var timings = [String: (line: Line, departureTimes: [Date])]()

        Alamofire.request("https://transit.api.here.com/v3/board.json?", method: .get, parameters: param).responseJSON { response in
            if let json = response.result.value as? [String: Any],
                let resJson = json["Res"] as? [String: Any],
                let multiNextDepartures = resJson["NextDepartures"] as? [String: Any],
                let multiNextDeparture = multiNextDepartures["Dep"] as? [[String: Any]] {
                for departures in multiNextDeparture {
                    if let dep = self.parseTimingsFromStationId(from: departures) {
                        let key = dep.line.name+"-"+dep.line.destination
                        if timings[key] != nil {
                            timings[key]?.departureTimes.append(contentsOf: dep.departureTimes)
                        } else {
                            timings[key] = dep
                        }
                    }
                }
                completion(Array(timings.values))
            } else {
                completion([])
                print("Failed in getting Departure Times for Lines from Station")
            }
        }
    }

    // MARK: Parse Methods
    func parseTimingsFromStationId(from json: [String: Any]) -> (line: Line, departureTimes: [Date])? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.timeZone = TimeZone.current
        
        guard let time = json["time"] as? String,
            let date = formatter.date(from: time),
            let transport = json["Transport"] as? [String: Any],
            let newLine = parseLine(from: transport)
        else { return nil }
       
        return (line: newLine, departureTimes: [date])
    }

    func parseStation(from json: [String: Any]) -> Station? {
        guard let name = json["name"] as? String,
            let code = json["id"] as? String,
            let long = json["x"] as? Double,
            let lat = json["y"] as? Double,
            let transportsJson = json["Transports"] as? [String: Any],
            let variousTransports = transportsJson["Transport"] as? [[String: Any]]
        else { return nil }

        let location = CLLocation(latitude: lat, longitude: long)
        var lines: [Line] = [Line]()
        var transitModes = [TransitMode]()

        for transport in variousTransports {
            if let newLine = parseLine(from: transport) {
                transitModes.append(newLine.transitMode)
                lines.append(newLine)
            }
        }
        return Station(name: name, code: Int(code) ?? 0, transitModes: transitModes, lines: lines, location: location)
    }
    
    func parseLine(from json: [String : Any]) -> Line? {
        guard let lineName = json["name"] as? String,
            let lineDestination = json["dir"] as? String,
            let at = json["At"] as? [String: Any],
            let modeNum = json["mode"] as? Int
        else { return nil }
        
        var colorString = at["color"] as? String ?? ""
        if colorString == "#FEF0B5" || colorString == "#FFFF33" {
            colorString = "#F3B43F"
        }
        let color = UIColor(hex: Int(colorString.dropFirst(), radix: 16) ?? 0x4A90E2)
        let transitMode = transitModeConvert(num: modeNum)
        let ag = Agency.zero
        
        return Line(name: lineName, agency: ag, destination: lineDestination, color: color, transitMode: transitMode)
    }

    func transitModeConvert(num: Int) -> TransitMode {
        switch num {
        case 3:
            return TransitMode.calTrain
        case 5:
            return TransitMode.bus
        case 8:
            return TransitMode.lightRail
        case 7:
            return TransitMode.bart
        default:
            return TransitMode.bus
        }
    }
}
