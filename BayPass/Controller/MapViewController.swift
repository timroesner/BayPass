//
//  ViewController.swift
//  BayPass
//
//  Created by Tim Roesner on 9/14/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

import CoreLocation
import SnapKit
import UIKit

class MapViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellIdentifier = "station"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let stations = [Station(name: "Santa Clara Station", code: 922, transitModes: [.bus, .lightRail], lines: ["922", "323", "923", "23", "181"], location: CLLocation(latitude: 0.0, longitude: 0.0)), Station(name: "San Jose Diridon", code: 112, transitModes: [.bus, .lightRail, .calTrain], lines: ["Cal", "922", "923", "17", "64"], location: CLLocation(latitude: 0.0, longitude: 0.0)), Station(name: "7th & San Fernando", code: 922, transitModes: [.bus], lines: ["64", "72", "73", "81"], location: CLLocation(latitude: 0.0, longitude: 0.0))]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! StationSearchResultTableViewCell
        cell.setup(with: stations[indexPath.row])
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addLabel(title: "Map")
        
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 250))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(StationSearchResultTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        self.view.addSubview(tableView)
    }
}
