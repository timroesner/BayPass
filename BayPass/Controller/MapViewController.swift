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
        loadJSON()
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
}
