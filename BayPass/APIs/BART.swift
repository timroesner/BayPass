//
//  BART.swift
//  BayPass
//
//  Created by Tim Roesner on 2/2/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import Alamofire
import Foundation

class BART {
    func getFare(from: String, to: String, completion: @escaping (Double) -> Void) {
        let params = [
            "cmd": "fare",
            "orig": from,
            "dest": to,
            "key": Credentials().bartToken,
            "json": "y",
        ]
        Alamofire.request("https://api.bart.gov/api/sched.aspx", method: .get, parameters: params).responseJSON { response in
            if let error = response.error {
                print(error.localizedDescription)
                return
            }
            if let json = response.result.value as? [String: Any] {
                guard let root = json["root"] as? [String: Any],
                    let fares = root["fares"] as? [String: Any],
                    let fare = fares["fare"] as? [[String: Any]]
                else { return }
                for object in fare {
                    if object["@class"] as? String == "clipper" {
                        guard let stringAmount = object["@amount"] as? String,
                            let amount = Double(stringAmount)
                        else { return }
                        completion(amount)
                    }
                }
            }
        }
    }

    func getAllStations(completion: @escaping ([String: String]) -> Void) {
        let params = [
            "cmd": "stns",
            "key": Credentials().bartToken,
            "json": "y",
        ]
        Alamofire.request("https://api.bart.gov/api/stn.aspx", method: .get, parameters: params).responseJSON { response in
            if let error = response.error {
                print(error.localizedDescription)
                return
            }
            if let json = response.result.value as? [String: Any] {
                guard let root = json["root"] as? [String: Any],
                    let stations = root["stations"] as? [String: Any],
                    let stationsArray = stations["station"] as? [[String: Any]]
                else { return }
                var result = [String: String]()
                for station in stationsArray {
                    guard let name = station["name"] as? String,
                        let abbriveation = station["abbr"] as? String
                    else { continue }
                    result[name] = abbriveation
                }
                completion(result)
            }
        }
    }
}
