//
//  StationViewController.swift
//  BayPass
//
//  Created by Ayesha Khan on 4/18/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import OverlayContainer
import SnapKit
import UIKit

class StationViewController: UIViewController {
    var myTableView = UITableView()
    var station: Station?
    var lines: [Line]?
    let searchVC = SearchViewController()
    var notchPercentages = [CGFloat]()
    let bottomSheet = OverlayContainerViewController(style: .rigid)

//    let mapVC = MapViewController()

    var cancelLabel: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        image.image = #imageLiteral(resourceName: "close")

        return image
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        lines = station?.lines
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: view.topAnchor, constant: 500).isActive = true

        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 21
        cancelLabel.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        cancelLabel.addGestureRecognizer(tap)
        setupViews()
    }

    func setupViews() {
        setUpTitle()
        setUpTableView()
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
            make.topMargin.left.equalTo(15)
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

extension StationViewController: UITableViewDelegate, UITableViewDataSource {
    func setUpTableView() {
        myTableView.frame = CGRect(x: 22, y: -22, width: 325, height: 3500)
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.separatorColor = .clear
//        myTableView.separatorInset = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 50)
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(myTableView)
        myTableView.rowHeight = UITableView.automaticDimension
        myTableView.register(LineTableViewCell.self, forCellReuseIdentifier: "Cell")
        myTableView.rowHeight = 80
        myTableView.isScrollEnabled = true
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return lines?.count ?? 0
    }

    func tableView(_: UITableView, heightForFooterInSection _: Int) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! LineTableViewCell
        let defaultLine = Line(name: "m", agency: Agency.ACE, destination: "n", color: #colorLiteral(red: 0.2901960784, green: 0.5647058824, blue: 0.8862745098, alpha: 1), transitMode: TransitMode.bart)
        cell.setup(with: lines?[indexPath.row] ?? defaultLine)

        return cell
    }
}

extension StationViewController: OverlayContainerViewControllerDelegate {
    func overlayContainerViewController(_: OverlayContainerViewController, heightForNotchAt index: Int, availableSpace: CGFloat) -> CGFloat {
        return availableSpace * notchPercentages[index]
    }

    func numberOfNotches(in _: OverlayContainerViewController) -> Int {
        return notchPercentages.count
    }

    @objc func tapFunction(sender _: UITapGestureRecognizer) {
        print("Tapped")
        removeChild(self)
        searchVC.resetSearch()
        bottomSheet.drivingScrollView = searchVC.tableView
        bottomSheet.invalidateNotchHeights()
        notchPercentages = [0.20, 0.93]
        bottomSheet.viewControllers = [searchVC]

        //        searchVC.resetSearch()
        //        bottomSheet.drivingScrollView = searchVC.tableView
        //        bottomSheet.invalidateNotchHeights()
        //        notchPercentages = [0.20, 0.93]
        //        bottomSheet.viewControllers = [searchVC]

        //        mapVC.cancelRouting()
        //        mapVC.setupSearchView()
        // TODO: Display SearchVC
        //        mapVC.centerOnUserLocation()
        //        mapVC.setupSearchView()
    }
}
