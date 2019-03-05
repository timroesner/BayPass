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
    func getStation(center: CLLocationCoordinate2D, radius: Int, max: Int, completion _: @escaping ([Station]) -> Void) {
        let param = [
            "center": "\(center.latitude),\(center.longitude)",
            "radius": radius,
            "app_id": "jTmFALvm9FfNyXRTRzOc",
            "app_code": "K0MCBAmf30FXqJpTUIWfLg",
            "max": max,
        ] as [String: Any]

        var results = [Station]()

        Alamofire.request("https://transit.api.here.com/v3/stations/by_geocoord.json?", method: .get, parameters: param).responseJSON { resp in
            if let json = resp.result.value as? [String: Any],
                let resJson = json["Res"] as? [String: Any],
                let stationsJson = resJson["Stations"] as? [String: Any],
                let stnsJson = stationsJson["Stn"] as? [Dictionary<String, Any>] {
                for stnJson in stnsJson {
                    if let newStation = self.parseStation(from: stnJson) {
                        results.append(newStation)
                        print(newStation)
                    }
                }
            }
        }
    }

    func getLine(stationId: Int, completion: @escaping ([Line]) -> Void) {
        let param = [
            "app_id": "jTmFALvm9FfNyXRTRzOc",
            "app_code": "K0MCBAmf30FXqJpTUIWfLg",
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
                    self.parseLine(from: line, stationID: stationId)
                    print(line)
                }
                completion(results)
            }
        }
    }

    // TODO: Change time from String to timeStamp
    func getAgency(stationId: Int, time: String, completion: @escaping (String) -> Void) {
        let param = [
            "app_id": "jTmFALvm9FfNyXRTRzOc",
            "app_code": "K0MCBAmf30FXqJpTUIWfLg",
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
                let multiNextDeparture = multiNextDepartures["MultiNextDeparture"] as? [Dictionary<String, Any>] {
                for nextDeparture in multiNextDeparture {
                    if let agency = self.parseOperatorFromStationId(from: nextDeparture) {
                        results.append(agency)
                    }
                }
                completion(results)
            }
        }
    }

    func parseOperatorFromStationId(from json: Dictionary<String, Any>) -> String? {
        var name = ""
        var id = ""
        var abbrv = ""
        let nextDepartures = json["NextDepartures"] as? Dictionary<String, Any>
        let operators = nextDepartures?["Operators"] as? Dictionary<String, Any>
        if let op = operators?["Op"] as? [[String: Any]],
            let op1 = op.first {
            name = op1["name"] as! String
            id = op1["code"] as! String
            abbrv = op1["short_name"] as! String
        }
        return abbrv
    }

    func parseStation(from json: Dictionary<String, Any>) -> Station? {
        let name = json["name"] as? String
        let code = json["id"] as? String
        let x = json["x"] as? Double
        let y = json["y"] as? Double

        let location = CLLocation(latitude: x ?? 0, longitude: y ?? 0)
        let transports = json["Transports"] as? Dictionary<String, Any>
        let transport = transports?["Transport"] as? [Dictionary<String, Any>]
        let transportData = transport?[0] as? Dictionary<String, Any>

        let modeNum = transportData?["mode"] as? Int
        let transitMode = transitModeConvert(num: modeNum ?? 0)
        var lines: [Line] = [Line]()

        getLine(stationId: Int(code!) ?? 0, completion: { resp in
            lines = resp
        })
        return Station(name: name ?? "", code: Int(code!) ?? 0, transitModes: [transitMode], lines: lines, location: location)
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
        print("\(name) \(destination) \(color) ")
        var agencyAbbrv: String?
        getAgency(stationId: stationID, time: "2019-06-24T08%3A00%3A00", completion: { agencyAb in
            agencyAbbrv = agencyAb
        })

        let abrv = Agency(rawValue: agencyAbbrv ?? "")

        return Line(name: name ?? "", agency: abrv ?? Agency(rawValue: "CT")!, destination: destination ?? "", color: color ?? UIColor.blue, transitMode: transitMode)
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
