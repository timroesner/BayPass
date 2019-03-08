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
    // MARK: Get Requests for here

    let group = DispatchGroup()

    // Returns an agency for given Station ID
    func getAgencyFromStationId(stationId: Int, completion: @escaping (Agency) -> Void) {
        let param = [
            "app_id": Credentials().hereAppID,
            "app_code": Credentials().hereAppCode,
            "lang": "en",
            "stnIds": stationId,
            "max": 2,
            "time": "2019-06-24T08%3A00%3A00", // TODO: Remember to change
        ] as [String: Any]
        var results = Agency.zero
        Alamofire.request("https://transit.api.here.com/v3/multiboard/by_stn_ids.json?", method: .get, parameters: param).responseJSON { response in
            if let json = response.result.value as? [String: Any],
                let resJson = json["Res"] as? [String: Any],
                let multiNextDepartures = resJson["MultiNextDepartures"] as? [String: Any],
                let multiNextDeparture = multiNextDepartures["MultiNextDeparture"] as? [[String: Any]] {
                var count = multiNextDeparture.count - 1
                for nextDeparture in multiNextDeparture {
                    if let agency = self.parseOperatorFromStationId(from: nextDeparture) {
                        results = Agency(rawValue: agency) ?? Agency.zero
                        print("\(stationId) : \(Agency(rawValue: agency))")
                        completion(results)
                    }
                }
            }
        }
    }

    func getStationsWithAgency(center: CLLocationCoordinate2D, radius: Int, max: Int, agencies: [Agency], completion: @escaping ([Station]) -> Void) {
        let param = [
            "center": "\(center.latitude),\(center.longitude)",
            "radius": radius,
            "app_id": Credentials().hereAppID,
            "app_code": Credentials().hereAppCode,
            "max": max,
        ] as [String: Any]

        var results = [Station]()
        var count = 0

        Alamofire.request("https://transit.api.here.com/v3/stations/by_geocoord.json?", method: .get, parameters: param).responseJSON { resp in
            if let json = resp.result.value as? [String: Any],
                let resJson = json["Res"] as? [String: Any],
                let stationsJson = resJson["Stations"] as? [String: Any],
                let stnsJson = stationsJson["Stn"] as? [Dictionary<String, Any>] {
                for stnJson in stnsJson {
                    if let newStation = self.parseStation(from: stnJson, agency: agencies[count]) {
                        results.append(newStation)
                        print(newStation)
                    }
                    count += 1
                }
                completion(results)
            }
        }
    }

    func getStations(center: CLLocationCoordinate2D, radius: Int, max: Int, agency: Agency, completion: @escaping ([Station]) -> Void) {
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

                self.getAgencies(stationIds: stations.map { $0.code }, time: "2019-06-24T08%3A00%3A00") { agencyStationIDs in
                    for index in 0 ..< stations.count {
                        if let agency = agencyStationIDs[stations[index].code] {
                            for lineIndex in 0 ..< stations[index].lines.count {
                                stations[index].lines[lineIndex].agency = agency
                            }
                        }
                    }
                    completion(stations)
                }
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
                let stnsJson = stationsJson["Stn"] as? [Dictionary<String, Any>] {
                for stnJson in stnsJson {
                    if let newStation = self.parseStation(from: stnJson, agency: agency) {
                        results.append(newStation)
                        print(newStation)
                    }
                }
                completion(results)
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
                let stnsJson = stationsJson["Stn"] as? [Dictionary<String, Any>] {
                for stnJson in stnsJson {
                    if let newStation = self.parseStationForId(from: stnJson) {
                        results.append(newStation)
                        print(newStation)
                    }
                }
                completion(results)
            }
        }
    }

    func parseStationForId(from json: Dictionary<String, Any>) -> Int? {
        let stationIdString = json["id"] as? String
        var stationId = Int(stationIdString!)

        return stationId
    }
    }

    func getLine(stationId: Int, completion: @escaping ([Line]) -> Void) {
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
                let lineJson = linesJson["LineInfo"] as? [Dictionary<String, Any>] {
                for line in lineJson {
                    if let line = self.parseLine(from: line, stationID: stationId) {
                        results.append(line)
                    }
                }
                completion(results)
            }
        }
    }
        

    func getAgency(stationId: Int, time: String, completion: @escaping (String) -> Void) {
        // TODO: Change time from String to timeStamp
        let param = [
            "app_id": Credentials().hereAppID,
            "app_code": Credentials().hereAppCode,
            "lang": "en",
            "stnIds": stationId,
            "max": 2,
            "time": time,
        ] as [String: Any]

        var results: String = ""

        Alamofire.request("https://transit.api.here.com/v3/multiboard/by_stn_ids.json?", method: .get, parameters: param).responseJSON { response in
            if let json = response.result.value as? [String: Any],
                let resJson = json["Res"] as? [String: Any],
                let multiNextDepartures = resJson["MultiNextDepartures"] as? [String: Any],
                let multiNextDeparture = multiNextDepartures["MultiNextDeparture"] as? [[String: Any]] {
                for nextDeparture in multiNextDeparture {
                    if let agency = self.parseOperatorFromStationId(from: nextDeparture) {
                        results.append(agency)
                    }
                }
                completion(results)
            }
        }
    }

    // MARK: Parsing

    func parseOperatorFromStationId(from json: Dictionary<String, Any>) -> String? {
        var abbrv = ""
        let nextDepartures = json["NextDepartures"] as? Dictionary<String, Any>
        let operators = nextDepartures?["Operators"] as? Dictionary<String, Any>
        if let op = operators?["Op"] as? [[String: Any]],
            let op1 = op.first {
            abbrv = op1["short_name"] as! String // TODO:
        }
        return abbrv
    }

    func parseStation(from json: Dictionary<String, Any>, agency: Agency) -> Station? {
        let name = json["name"] as? String
        let code = json["id"] as? String
        let x = json["x"] as? Double
        let y = json["y"] as? Double

        let location = CLLocation(latitude: x ?? 0, longitude: y ?? 0)
        let transports = json["Transports"] as? Dictionary<String, Any>

        let transport = transports?["Transport"] as? [Dictionary<String, Any>]
        let transportData = transport?[0] as? Dictionary<String, Any>
        var lines: [Line] = [Line]()
        var transitModes = [TransitMode]()

        var codeNum = Int(code!)

        for transport1 in transport! {
            let lineName = transport1["name"] as? String
            let lineDestination = transport1["dir"] as? String
            let at = transport1["At"] as? Dictionary<String, Any>
            let colorString = at?["color"] as? String
            let color = UIColor(hexString: colorString ?? "")
            let modeNum = transportData?["mode"] as? Int
            let transitMode = transitModeConvert(num: modeNum ?? 0)
            var ag = Agency.ACE
            transitModes.append(transitMode)

            lines.append(Line(name: lineName ?? "", agency: agency, destination: lineDestination ?? "", color: color ?? #colorLiteral(red: 0.2901960784, green: 0.5647058824, blue: 0.8862745098, alpha: 1), transitMode: transitMode)) // TODO: Fix Agency
        }
        return Station(name: name ?? "", code: Int(code!) ?? 0, transitModes: transitModes, lines: lines, location: location)
    }

    func parseLine(from json: Dictionary<String, Any>, stationID: Int) -> Line? {
        let tranport = json["Transport"] as? Dictionary<String, Any>
        let name = tranport?["name"] as? String
        let destination = tranport?["dir"] as? String

        let transitModeNum = tranport?["mode"] as? Int
        let transitMode = transitModeConvert(num: transitModeNum ?? 0)

        let at = tranport?["As"] as? Dictionary<String, Any>
        let colorString = at?["color"] as? String
        let color = UIColor(hexString: colorString ?? "")
        var agencyAbbrv: String?

        getAgency(stationId: stationID, time: "2019-06-24T08%3A00%3A00", completion: { agencyAb in
            agencyAbbrv = agencyAb
        })

        let abrv = Agency(rawValue: agencyAbbrv ?? "")

        return Line(name: name ?? "", agency: abrv ?? Agency(rawValue: "AC")!, destination: destination ?? "", color: color ?? #colorLiteral(red: 0.2901960784, green: 0.5647058824, blue: 0.8862745098, alpha: 1), transitMode: transitMode)
    }

    func transitModeConvert(num: Int) -> TransitMode {
        switch num { // TODO: Fix this
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
