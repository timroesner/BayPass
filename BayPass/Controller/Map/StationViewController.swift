//
//  StationViewController.swift
//  BayPass
//
//  Created by Ayesha Khan on 4/18/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import SnapKit
import UIKit
import MapKit

class StationViewController: UIViewController {
    var station: Station
    let lineTableView = UITableView()
    let lineCellId = "lineCell"
    let stationNameLabel = UILabel()
    let stationImageView = UIImageView()
    let getDirectionsButton = UIButton()
    var cancelView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "close")
        return imageView
    }()
    var nextDepartures = [(line: Line, departureTimes: [Date])]()
    var parentMapVC: MapViewController?
    
    init(station: Station) {
        self.station = station
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 21
        view.layer.applySketchShadow(color: .black, alpha: 0.20, x: 6, y: 6, blur: 25, spread: 5)
        
        setUpConstraints()
        setUpTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setViewInfos()
        fetchDepartureTimes()
    }
    
    func setViewInfos() {
        stationImageView.image = station.getIcon()
        stationNameLabel.text = station.name.replacingOccurrences(of: "\\s?\\([\\w\\s]*\\)", with: "", options: .regularExpression)
    }

    func setUpConstraints() {
        let moveIndicator = MoveIndicator()
        view.addSubview(moveIndicator)
        moveIndicator.setConstraints()
        
        stationImageView.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.addSubview(stationImageView)
        stationImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.left.equalToSuperview().offset(12)
            make.width.height.equalTo(50)
        }

        cancelView.isUserInteractionEnabled = true
        view.addSubview(cancelView)
        cancelView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.right.equalToSuperview().inset(12)
            make.width.height.equalTo(25)
        }
        
        stationNameLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        view.addSubview(stationNameLabel)
        stationNameLabel.snp.makeConstraints { make in
            make.left.equalTo(stationImageView.snp.right).offset(2)
            make.top.equalTo(stationImageView).offset(2)
            make.right.equalTo(cancelView.snp.left).offset(4)
        }
        
        getDirectionsButton.setTitle("Get Directions", for: .normal)
        getDirectionsButton.setTitleColor(UIColor(hex: 0x007AFF), for: .normal)
        getDirectionsButton.addTarget(self, action: #selector(getDirections), for: .touchUpInside)
        view.addSubview(getDirectionsButton)
        getDirectionsButton.snp.makeConstraints { (make) in
            make.top.equalTo(stationNameLabel.snp.bottom).offset(2)
            make.left.equalTo(stationNameLabel)
            make.height.equalTo(20)
        }

        view.addSubview(lineTableView)
        lineTableView.snp.makeConstraints { make in
            make.top.equalTo(stationImageView.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(12)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func fetchDepartureTimes() {
        Here.shared.getDepartureTimesForAStation(stationId: station.code) { results in
            self.nextDepartures = results
            self.nextDepartures.sort(by: { ($0.departureTimes.first ?? Date(timeIntervalSince1970: 0)) < ($1.departureTimes.first ?? Date(timeIntervalSince1970: 0)) })
            self.lineTableView.reloadData()
        }
    }
    
    @objc func getDirections() {
        let placemark = MKPlacemark(coordinate: station.location.coordinate, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = station.name
        parentMapVC?.displayRoute(to: mapItem)
    }
    
    required init?(coder aDecoder: NSCoder) {
        print("init(coder:) has not been implemented for StationViewController")
        return nil
    }
}

extension StationViewController: UITableViewDelegate, UITableViewDataSource {
    func setUpTableView() {
        lineTableView.dataSource = self
        lineTableView.delegate = self
        lineTableView.separatorColor = .clear
        lineTableView.showsVerticalScrollIndicator = false
        lineTableView.register(LineTableViewCell.self, forCellReuseIdentifier: lineCellId)
        lineTableView.rowHeight = 80
        lineTableView.allowsSelection = false
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return nextDepartures.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: lineCellId) as! LineTableViewCell
        cell.setup(with: nextDepartures[indexPath.row])
        return cell
    }
}
