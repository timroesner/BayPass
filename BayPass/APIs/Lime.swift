//
//  Lime.swift
//  BayPass
//
//  Created by Tim Roesner on 3/14/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import Alamofire
import CoreLocation
import Foundation

class Lime {
    let limeCompany = ScooterCompany(name: "Lime", icon: #imageLiteral(resourceName: "Scooter"), color: UIColor(hex: 0x05C500))

    func getScooters(fromLocation: CLLocationCoordinate2D, completion: @escaping ([Scooter]) -> Void) {
        var result = [Scooter]()

        let latitude = fromLocation.latitude
        let longitude = fromLocation.longitude

        let params: [String: Any] = [
            "query": "query ($lat: Float!, $lng: Float!) {\n  vehicles(lat: $lat, lng: $lng) {\n\t\ttype\nlat\nlng\n }\n}",
            "variables": ["lat": latitude, "lng": longitude],
        ]
        Alamofire.request("https://api.multicycles.org/v1?access_token=\(Credentials().multicycles)", method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { response in
            if let jsonResponse = response.result.value as? [String: Any],
                let json = jsonResponse["data"] as? [String: Any],
                let allScooters = json["vehicles"] as? [[String: Any]] {
                for scooterJson in allScooters {
                    if let newScooter = self.parseJson(json: scooterJson) {
                        result.append(newScooter)
                    }
                }
                completion(result)
            }
        }
    }

    func parseJson(json: [String: Any]) -> Scooter? {
        guard let type = json["type"] as? String,
            type == "SCOOTER",
            let latitude = json["lat"] as? Double,
            let longitude = json["lng"] as? Double
        else {
            return nil
        }

        let location = CLLocation(latitude: latitude, longitude: longitude)
        return Scooter(location: location, company: limeCompany)
    }
}
