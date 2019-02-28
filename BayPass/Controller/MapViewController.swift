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

class MapViewController: UIViewController {
    var goog = Here()
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

//        goog.getStation(center: CLLocationCoordinate2D(latitude: 37.3524628, longitude: -121.9707281), radius: 400, max: 20) { (resp) in
//            print(resp)
//        }
//        goog.getLine(stationId: 718610044) { (resp) in
//            print(resp)
//        }
        goog.getAgency(stationId: 718_610_044, time: "2019-06-24T08%3A00%3A00") { response in
            print(response)
        }
    }
}
