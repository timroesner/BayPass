//
//  StationViewController.swift
//  BayPass
//
//  Created by Ayesha Khan on 4/18/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import UIKit

class StationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
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
        tableView.estimatedRowHeight = 57.0

        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 21
        setupViews()
    }

    func setupViews() {}
}
