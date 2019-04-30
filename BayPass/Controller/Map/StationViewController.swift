//
//  StationViewController.swift
//  BayPass
//
//  Created by Ayesha Khan on 4/18/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import SnapKit
import UIKit

class StationViewController: UIViewController {
    var myTableView = UITableView()
    var station: Station?
    var lines: [Line]?
    let searchVC = SearchViewController()

    var cancelLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 80))
        label.text = "ⓧ"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.7136465907, green: 0.7137709856, blue: 0.7136387825, alpha: 1)

        return label
    }()

    @objc func tapFunction(sender _: UITapGestureRecognizer) {
        print("Tapped")
        parent?.addChild(searchVC)
        removeChild(self)
        // TODO: Display SearchVC
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        lines = station?.lines
        print("🎀\(lines)")

        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: view.topAnchor, constant: 500).isActive = true

        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 21
        cancelLabel.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        cancelLabel.addGestureRecognizer(tap)
        setupViews()
        setUpTableView()
    }

    func setupViews() {
        setUpTitle()
    }

    func setUpTitle() {
        let stationName = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        stationName.text = station?.name.replacingOccurrences(of: "\\s?\\([\\w\\s]*\\)", with: "", options: .regularExpression) // Removes Parantheses
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

    func setUpTableView() {
        myTableView = UITableView(frame: CGRect(x: 22, y: 60, width: 300, height: 900)) // TODO: Fix so its auto
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.separatorColor = .clear
        view.addSubview(myTableView)
        myTableView.register(StationTableViewCell.self, forCellReuseIdentifier: "Cell")
    }
}

extension StationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return lines?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? StationTableViewCell else { fatalError("Unable to create cell") }
        cell.stationName.text = lines?[indexPath.row].name
        cell.color = lines?[indexPath.row].color ?? #colorLiteral(red: 0.2901960784, green: 0.5647058824, blue: 0.8862745098, alpha: 1)
        return cell
    }
}
