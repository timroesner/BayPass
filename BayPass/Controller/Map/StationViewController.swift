//
//  StationViewController.swift
//  BayPass
//
//  Created by Ayesha Khan on 4/18/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import UIKit

protocol StationDelegate {
    func onStationClicked(station: Station)
}

class StationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, StationDelegate {
    var station: Station?

    func onStationClicked(station: Station) {
        self.station = station
        print("😁\(station)")
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 0
    }

    func tableView(_: UITableView, cellForRowAt _: IndexPath) -> UITableViewCell {
        return StationTableViewCell()
    }

    private(set) var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.estimatedRowHeight = 100.0

        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 21
        setupViews()
    }

    func setupViews() {
        setUpTitle()
    }

    func setUpTitle() {
        let stationName = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 21))
        stationName.text = station?.name
        view.addSubview(stationName)
        print("😀\(stationName.text)")
    }
}
