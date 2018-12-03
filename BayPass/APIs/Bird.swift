//
//  Bird.swift
//  BayPass
//
//  Created by Tim Roesner on 12/2/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

import Alamofire
import CoreLocation
import Foundation

var birdTokenExpireDate = Date()

class Bird {
    let birdCompany = ScooterCompany(name: "Bird", icon: #imageLiteral(resourceName: "Scooter"), color: .black)

    init() {
        if birdTokenExpireDate < Date() {
            renewToken()
        }
    }

    private func renewToken() {
        let params = ["email": "asdf@google.com"]
        let headers = [
            "Platform": "ios",
            "Device-id": UUID().uuidString,
            "Content-type": "application/json",
        ]
        Alamofire.request("https://api.bird.co/user/login", method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON {
            response in
            if let error = response.error {
                print(error.localizedDescription)
                return
            }
            if let json = response.result.value as? [String: Any] {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                birdTokenExpireDate = formatter.date(from: json["expires_at"] as? String ?? "") ?? Date()
            }
        }
    }

    func getScooters(fromLocation: CLLocation, radius: Double, completion: @escaping ([Scooter]) -> Void) {
        var result = [Scooter]()

        let latitude = fromLocation.coordinate.latitude
        let longitude = fromLocation.coordinate.longitude

        let params = [
            "latitude": latitude,
            "longitude": longitude,
            "radius": radius,
        ]
        let headers = [
            "Authorization": "Bird \("birdToken".credentials())",
            "Device-id": UUID().uuidString,
            "App-Version": "3.0.5",
            "Location": "{\"latitude\": \(latitude), \"longitude\": \(longitude)}",
        ]
        Alamofire.request("https://api.bird.co/bird/nearby", method: .get, parameters: params, headers: headers).responseJSON { response in
            if let error = response.error {
                print(error.localizedDescription)
                return
            }
            if let json = response.result.value as? [String: Any] {
                let allScooters = json["birds"] as? [[String: Any]] ?? [[:]]
                for scooterJson in allScooters {
                    result.append(self.parseJson(json: scooterJson))
                }
                completion(result)
            }
        }
    }

    func parseJson(json: [String: Any]) -> Scooter {
        let code = json["code"] as? String ?? ""
        let locationJson = json["location"] as? [String: Any] ?? [:]
        let location = CLLocation(latitude: locationJson["latitude"] as? Double ?? 0.0, longitude: locationJson["longitude"] as? Double ?? 0.0)
        let battery = String(json["battery_level"] as? Int ?? 0)

        return Scooter(code: code, location: location, battery: battery, company: birdCompany)
    }
}
