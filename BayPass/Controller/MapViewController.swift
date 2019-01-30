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

//--------- Station ------------
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

//--------- BART Line ------------
/*
 {
 "Id": "Yellow",
 "Name": "Antioch - SFIA/Millbrae",
 "TransportMode": "rail",
 "PublicCode": "Yellow",
 "SiriLineRef": "Yellow",
 "Montiored": true,
 "OperatorRef": "BA"
 }
 */

struct LineInfo {
    var Id: String
    var Name: String
    var TransportMode: String
    var PublicCode: String
    var SiriLineRef: String
    var Montiored: Bool
    var OperatorRef: String
    
    init(_ dictionary: [String: Any]) {
        self.Id = dictionary["Id"] as? String ?? ""
        self.Name = dictionary["Name"] as? String ?? ""
        self.TransportMode = dictionary["TransportMode"] as? String ?? ""
        self.PublicCode = dictionary["PublicCode"] as? String ?? ""
        self.SiriLineRef = dictionary["SiriLineRef"] as? String ?? ""
        self.Montiored = dictionary["Montiored"] as? Bool ?? false
        self.OperatorRef = dictionary["OperatorRef"] as? String ?? ""
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
    }
    
}
