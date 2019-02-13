//
//  511.swift
//  BayPass
//
//  Created by Ayesha Khan on 2/3/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import Foundation

// --------- AGENCIES ------------
struct Agencies: Codable {
    let Id: String
    let Name: String

    init(id: String, name: String) {
        Id = id
        Name = name
    }
}

// --------- STATIONS ------------

struct Stations: Decodable {
    let stations: [StationInfo]

    enum CodingKeys: String, CodingKey {
        case contents = "Contents"
    }

    enum DataObjects: String, CodingKey {
        case dataObjects
    }

    enum ScheduledStopPoint: String, CodingKey {
        case scheduledStopPoint = "ScheduledStopPoint"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let dataObjects = try values.nestedContainer(keyedBy: DataObjects.self,
                                                     forKey: .contents)
        let scheduledStopPoint = try dataObjects.nestedContainer(keyedBy: ScheduledStopPoint.self,
                                                                 forKey: .dataObjects)

        stations = try scheduledStopPoint.decode([StationInfo].self,
                                                 forKey: .scheduledStopPoint)
    }
}

// --------- STATION INFO ------------

struct StationInfo: Decodable {
    let id: String
    let Name: String
    enum Location: String, CodingKey {
        case Location
    }

    let StopType: String

    init(id: String, Name: String, stopType: String) {
        self.id = id
        self.Name = Name
        StopType = stopType
    }
}

// --------- LINE ------------

struct LineInfo {
    var Id: String
    var Name: String
    var TransportMode: String
    var PublicCode: String
    var SiriLineRef: String
    var Montiored: Bool
    var OperatorRef: String

    init(_ dictionary: [String: Any]) {
        Id = dictionary["Id"] as? String ?? ""
        Name = dictionary["Name"] as? String ?? ""
        TransportMode = dictionary["TransportMode"] as? String ?? ""
        PublicCode = dictionary["PublicCode"] as? String ?? ""
        SiriLineRef = dictionary["SiriLineRef"] as? String ?? ""
        Montiored = dictionary["Montiored"] as? Bool ?? false
        OperatorRef = dictionary["OperatorRef"] as? String ?? ""
    }
}

protocol API511Delegate {
    var agencies: [Agencies] { get set }
    func getStopsFromStation()
    func getLineForOperatorId(_ id: String) -> [LineInfo]
}

class API511 {
    var api511Delegate: API511Delegate?
    // --------- Load Agencies ------------

    func getAgencies() -> [Agencies] {
        var agency = [Agencies]()
        let jsonUrlString = "https://api.511.org/transit/gtfsoperators?api_key=11f56fe7-a97a-40db-9d94-130584c8bac6"
        guard let url = URL(string: jsonUrlString) else { return [] }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            print("test1")

            guard let data = data else { return }
            do {
                let gtfsOperators = try JSONDecoder().decode([Agencies].self, from: data) // parsing filter out based on id and name
                print(gtfsOperators)
                for gtfs in gtfsOperators {
                    print("gtfs: \(gtfs)\n")
                    agency.append(Agencies(id: gtfs.Id, name: gtfs.Name))
                }

            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
        }.resume()

        api511Delegate?.agencies = agency
        return agency
    }

    // --------- Stops From Station ------------

    func getStopsFromStation(_ id: String) -> [StationInfo] {
        var stationsInfo = [StationInfo]()
        let jsonUrlString = "https://api.511.org/transit/stops?api_key=11f56fe7-a97a-40db-9d94-130584c8bac6&operator_id=" + id
        guard let url = URL(string: jsonUrlString) else { return [] }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            print("test2")

            guard let data = data else { return }
            do {
                let stations = try JSONDecoder().decode(Stations.self, from: data) // parsing filter out based on id and name
                print("\(stations.stations)\n")

                for st in stations.stations {
                    print("\(st)\n")
                    stationsInfo.append(StationInfo(id: st.id, Name: st.Name, stopType: st.StopType))
                }

            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
        }.resume()

        return stationsInfo
    }

    // --------- Line from Operator Id ------------

    func getLineForOperatorId(_ id: String) -> [LineInfo] {
        var lines = [LineInfo]()
        let jsonUrlString = "https://api.511.org/transit/lines?api_key=11f56fe7-a97a-40db-9d94-130584c8bac6&operator&operator_id=" + id
        guard let url = URL(string: jsonUrlString) else { return [] }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let dataResponse = data,
                error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return }
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    dataResponse, options: [])
                print(jsonResponse)

                guard let jsonArray = jsonResponse as? [[String: Any]] else {
                    return
                }

                for dic in jsonArray {
                    lines.append(LineInfo(dic))
                }
                for line in lines {
                    print(line.Name)
                    print("\n")
                }

            } catch let parsingError {
                print("Error", parsingError)
            }
        }.resume()

        return lines
    }
}
