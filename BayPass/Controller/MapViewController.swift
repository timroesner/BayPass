//
//  ViewController.swift
//  BayPass
//
//  Created by Tim Roesner on 9/14/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

import CoreLocation
import MapKit
import SnapKit
import UIKit

struct GTFSOperators: Decodable {
    let Id: String
    let Name: String
    let LastGenerated: String // Don't need this
}

/*
 id": "12TH",
 "Name": "12th St. Oakland City Center BART Station",
 "Location": {
 "Longitude": "-122.27145",
 "Latitude": "37.803768"
 },
 "StopType": "onstreetBus"
 */
struct StationInfo: Decodable {
    let id: String
    let Name: String
    enum Location: String, CodingKey {
        case Location
    }

    let StopType: String
}

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

class MapViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addLabel(title: "Map")

        let ticketView = TicketView(agency: "ACE", icon: #imageLiteral(resourceName: "Bus"), cornerRadius: 12)
        view.addSubview(ticketView)

        ticketView.snp.makeConstraints({ (make) -> Void in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(350)
            make.height.equalTo(200)
        })
        loadJSONForStation()
    }

    // Print JSON
    func loadJSON() {
        // alamofire use instead
        let jsonUrlString = "https://api.511.org/transit/gtfsoperators?api_key=11f56fe7-a97a-40db-9d94-130584c8bac6"
        guard let url = URL(string: jsonUrlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            print("test1")

            guard let data = data else { return }
            do {
                let gtfsOperators = try JSONDecoder().decode([GTFSOperators].self, from: data) // parsing filter out based on id and name
                print(gtfsOperators)

                for gtfs in gtfsOperators {
                    print("gtfs: \(gtfs)\n")
                }

            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
        }.resume()
    }

    // Station
    func loadJSONForStation() {
        // alamofire use instead
        let jsonUrlString = "https://api.511.org/transit/stops?api_key=11f56fe7-a97a-40db-9d94-130584c8bac6&operator_id=BA"
        guard let url = URL(string: jsonUrlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            print("test2")

            guard let data = data else { return }
            do {
                let stations = try JSONDecoder().decode(Stations.self, from: data) // parsing filter out based on id and name
                print("\(stations.stations)\n")

                for st in stations.stations {
                    print("\(st)\n")
                }

            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
        }.resume()
    }
}
