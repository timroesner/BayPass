//
//  StationViewController.swift
//  BayPass
//
//  Created by Ayesha Khan on 4/18/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import SnapKit
import UIKit

protocol StationDelegate {
    func onStationClicked(station: Station)
}

class StationViewController: UIViewController, StationDelegate {
    var station: Station?

    let cancelLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        label.text = "ⓧ"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.7136465907, green: 0.7137709856, blue: 0.7136387825, alpha: 1)
        return label
    }()

    func onStationClicked(station: Station) {
        self.station = station
    }

//    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
//        return 0
//    }
//
//    func tableView(_: UITableView, cellForRowAt _: IndexPath) -> UITableViewCell {
//        return StationTableViewCell()
//    }

    private(set) var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.tableFooterView = UIView(frame: CGRect.zero)
//        tableView.estimatedRowHeight = 30
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: view.topAnchor, constant: 500).isActive = true

        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 21
        setupViews()
    }

    func setupViews() {
        setUpTitle()
    }

    func setUpTitle() {
        let stationName = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        stationName.text = station?.name.replacingOccurrences(of: "\\s?\\([\\w\\s]*\\)", with: "", options: .regularExpression)
        stationName.font = stationName.font.withSize(25) // TODO: Format so it automatically fits
        stationName.font = UIFont.boldSystemFont(ofSize: 16)
        stationName.numberOfLines = 0

        let stationImage = station?.getIcon()
        let stationImageView = UIImageView(image: stationImage)
        stationImageView.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        var arrayOfLineViews = [UIView]()

        if let lines = station?.lines {
            for line in lines {
                let lineName = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
                lineName.text = line.name
                lineName.font = UIFont(name: "SFProText-Semibold", size: 200)
                lineName.font = UIFont.boldSystemFont(ofSize: 16)
                let lineImage = line.getIcon()
                let lineImageView = UIImageView(image: lineImage)
                let lineView: UIView = {
                    let view = UIView()
                    view.backgroundColor = line.color
                    view.addSubview(lineName)
                    view.addSubview(lineImageView)
                    view.layer.cornerRadius = 20
                    return view
                }()
                arrayOfLineViews.append(lineView)
            }
        }

        view.addSubview(stationName)
        view.addSubview(stationImageView)
        view.addSubview(cancelLabel)
        stationImageView.snp.makeConstraints { make in
            make.topMargin.left.equalTo(22)
            make.topMargin.equalTo(18)
        }
        stationName.snp.makeConstraints { make in
            make.left.equalTo(stationImageView.snp.right)
            make.topMargin.equalTo(26)
        }
        cancelLabel.snp.makeConstraints { make in
            make.topMargin.equalTo(20)
            make.right.equalTo(-22)
        }
    }
}
