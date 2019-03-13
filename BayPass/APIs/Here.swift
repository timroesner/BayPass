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
    // MARK: Get Requests for Here

    // Returns an agency for given Station ID
    func getAgencyFromStationId(stationId: Int, time: String, completion: @escaping (Agency) -> Void) {
        let param = [
            "app_id": Credentials().hereAppID,
            "app_code": Credentials().hereAppCode,
            "lang": "en",
            "stnIds": stationId,
            "max": 1,
            "time": time,
        ] as [String: Any]
        var results = Agency.zero
        Alamofire.request("https://transit.api.here.com/v3/multiboard/by_stn_ids.json?", method: .get, parameters: param).responseJSON { response in
            if let json = response.result.value as? [String: Any],
                let resJson = json["Res"] as? [String: Any],
                let multiNextDepartures = resJson["MultiNextDepartures"] as? [String: Any],
                let multiNextDeparture = multiNextDepartures["MultiNextDeparture"] as? [[String: Any]] {
                for nextDeparture in multiNextDeparture {
                    if let agency = self.parseOperatorFromStationId(from: nextDeparture) {
                        results = agency
//                        print("\(stationId) : \(Agency(rawValue: agency))")
                        completion(results)
                    }
                }
            } else {
                completion(.zero)
                print("Failed in getting Agency from StationId")
            }
        }
    }

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

                self.getAgencies(stationIds: stations.map { $0.code }, time: "2019-03-24T08%3A00%3A00") { agencyStationIDs in // TODO: Fix
                    for index in 0 ..< stations.count {
                        if let agency = agencyStationIDs[stations[index].code] {
                            for lineIndex in 0 ..< stations[index].lines.count {
                                stations[index].lines[lineIndex].agency = agency
                            }
                        }
                    }
                    completion(stations)
                    print(stations)
                }
            } else {
                print("Failed in getting Stations Near By")
                completion([])
            }
        }
    }

    func getStationIds(center: CLLocationCoordinate2D, radius: Int, max: Int, completion: @escaping ([Int]) -> Void) {
        let param = [
            "center": "\(center.latitude),\(center.longitude)",
            "radius": radius,
            "app_id": Credentials().hereAppID,
            "app_code": Credentials().hereAppCode,
            "max": max,
        ] as [String: Any]

        var results = [Int]()

        Alamofire.request("https://transit.api.here.com/v3/stations/by_geocoord.json?", method: .get, parameters: param).responseJSON { resp in
            if let json = resp.result.value as? [String: Any],
                let resJson = json["Res"] as? [String: Any],
                let stationsJson = resJson["Stations"] as? [String: Any],
                let stnsJson = stationsJson["Stn"] as? [[String: Any]] {
                for stnJson in stnsJson {
                    if let newStation = self.parseStationForId(from: stnJson) {
                        results.append(newStation)
//                        print(newStation)
                    }
                }
                completion(results)
            } else {
                print("Failed in getting Station Ids")
                completion([0])
            }
        }
    }

    func getLine(stationId: Int, time _: String, completion: @escaping ([Line]) -> Void) {
        let param = [
            "app_id": Credentials().hereAppID,
            "app_code": Credentials().hereAppCode,
            "stnId": stationId,
            "graph": "1",
        ] as [String: Any]

        var results = [Line]()
        Alamofire.request("https://transit.api.here.com/v3/lines/by_stn_id.json?", method: .get, parameters: param).responseJSON { response in
            if let json = response.result.value as? [String: Any],
                let resJson = json["Res"] as? [String: Any],
                let linesJson = resJson["LineInfos"] as? [String: Any],
                let lineJson = linesJson["LineInfo"] as? [[String: Any]] {
                for line in lineJson {
                    if let line = self.parseLine(from: line, stationID: stationId) {
                        results.append(line)
                    }
                }
                completion(results)
            } else {
                print("Failed in getting Lines")
                completion([])
            }
        }
    }
        

    func getAgency(stationId: Int, time: String, completion: @escaping (Agency) -> Void) {
        let param = [
            "app_id": Credentials().hereAppID,
            "app_code": Credentials().hereAppCode,
            "lang": "en",
            "stnIds": stationId,
            "max": 2,
            "time": time,
        ] as [String: Any]

        var results: Agency = Agency.zero

        Alamofire.request("https://transit.api.here.com/v3/multiboard/by_stn_ids.json?", method: .get, parameters: param).responseJSON { response in
            if let json = response.result.value as? [String: Any],
                let resJson = json["Res"] as? [String: Any],
                let multiNextDepartures = resJson["MultiNextDepartures"] as? [String: Any],
                let multiNextDeparture = multiNextDepartures["MultiNextDeparture"] as? [[String: Any]] {
                for nextDeparture in multiNextDeparture {
                    if let agency = self.parseOperatorFromStationId(from: nextDeparture) {
                        results = agency
                    }
                }
                completion(results)
//                print(results.rawValue)
            } else {
                print("Failed in getting Agency")
                completion(.zero)
            }
        }
    }

    func getAgencies(stationIds: [Int], time: String, completion: @escaping ([Int: Agency]) -> Void) {
        var results = [Int: Agency]()
        let group = DispatchGroup()

        print("Requesting: \(stationIds)")
        for station in stationIds {
            group.enter()
            getAgency(stationId: station, time: time) { resp in
                results[station] = resp
                print("Got result for station: \(station): \(resp)")
                group.leave()
            }
        }

        group.notify(queue: .main) {
            completion(results)
        }
    }

    // MARK: Parsing

    func parseStationForId(from json: [String: Any]) -> Int? {
        let stationIdString = json["id"] as? String
        let stationId = Int(stationIdString!)

        return stationId
    }

    func parseOperatorFromStationId(from json: [String: Any]) -> Agency? {
        var abbrv = ""
        let nextDepartures = json["NextDepartures"] as? [String: Any]
        let operators = nextDepartures?["Operators"] as? [String: Any]
        if let op = operators?["Op"] as? [[String: Any]],
            let op1 = op.first {
            abbrv = op1["short_name"] as! String
        }
        return Agency(rawValue: abbrv)
    }

    func parseStation(from json: [String: Any]) -> Station? {
        let name = json["name"] as? String
        let code = json["id"] as? String
        let x = json["x"] as? Double
        let y = json["y"] as? Double

        let location = CLLocation(latitude: x ?? 0, longitude: y ?? 0)
        let transports = json["Transports"] as? [String: Any]

        let transport = transports?["Transport"] as? [[String: Any]]
        let transportData = transport?[0] as? [String: Any]
        var lines: [Line] = [Line]()
        var transitModes = [TransitMode]()

        var codeNum = Int(code!)

        for transport1 in transport! {
            let lineName = transport1["name"] as? String
            let lineDestination = transport1["dir"] as? String
            let at = transport1["At"] as? [String: Any]
            let colorString = at?["color"] as? String
            let color = UIColor(hexString: colorString ?? "")
            let modeNum = transportData?["mode"] as? Int
            let transitMode = transitModeConvert(num: modeNum ?? 0)
            var ag = Agency.zero
            transitModes.append(transitMode)
            lines.append(Line(name: lineName ?? "", agency: ag, destination: lineDestination ?? "", color: color ?? #colorLiteral(red: 0.2901960784, green: 0.5647058824, blue: 0.8862745098, alpha: 1), transitMode: transitMode))
        }
        return Station(name: name ?? "", code: Int(code!) ?? 0, transitModes: transitModes, lines: lines, location: location)
    }

    func parseLine(from json: [String: Any], stationID: Int) -> Line? {
        let tranport = json["Transport"] as? [String: Any]
        let name = tranport?["name"] as? String
        let destination = tranport?["dir"] as? String

        let transitModeNum = tranport?["mode"] as? Int
        let transitMode = transitModeConvert(num: transitModeNum ?? 0)

        let at = tranport?["As"] as? [String: Any]
        let colorString = at?["color"] as? String
        let color = UIColor(hexString: colorString ?? "")
        var agencyAbbrv: Agency?

        getAgency(stationId: stationID, time: "2019-03-24T08%3A00%3A00", completion: { agencyAb in // TODO: CHANGE TIME
            agencyAbbrv = agencyAb
        })

        return Line(name: name ?? "", agency: agencyAbbrv ?? Agency.zero, destination: destination ?? "", color: color ?? #colorLiteral(red: 0.2901960784, green: 0.5647058824, blue: 0.8862745098, alpha: 1), transitMode: transitMode)
    }

    func transitModeConvert(num: Int) -> TransitMode {
        switch num {
        case 5:
            return TransitMode.bus
        case 3:
            return TransitMode.calTrain
        case 8:
            return TransitMode.bart
        default:
            return TransitMode.lightRail // also  8
        }
    }
}
