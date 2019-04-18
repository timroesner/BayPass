//
//  TicketViewController.swift
//  BayPass
//
//  Created by Tim Roesner on 10/18/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

import CoreLocation
import SnapKit
import UIKit

class TicketViewController: UIViewController {
    let ticketCarouselViewCellID = "ticketCarouselViewCellID"
    let ticketCarouselView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collection.backgroundColor = UIColor.white
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isScrollEnabled = true
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()

    let titleLbl = UILabel()
    var purchasedTicketTableView: UITableView = {
        let tableView = UITableView()
        tableView.isScrollEnabled = true
        return tableView
    }()

    let purchasedTicketTableViewCellID = "purchasedTicketTableViewCellID"

    let agencies = Agency.allCases.filter { $0.rawValue != "0" }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Tickets"

        ticketCarouselView.delegate = self
        ticketCarouselView.dataSource = self
        ticketCarouselView.register(TicketCarouselViewCell.self, forCellWithReuseIdentifier: ticketCarouselViewCellID)
        setUpTicketCarouselView()

        purchasedTicketTableView.rowHeight = 93.0
        purchasedTicketTableView.dataSource = self
        purchasedTicketTableView.delegate = self
        purchasedTicketTableView.tableFooterView = UIView(frame: CGRect.zero)
        purchasedTicketTableView.register(PurchasedTicketCell.self, forCellReuseIdentifier: purchasedTicketTableViewCellID)
        layoutTableView()

        
        // MARK: temporary data
        UserManager.shared.clearAllPurchasedTickets()
        let expiredDuration = DateInterval(start: Date(timeIntervalSinceNow: -470_482.0), end: Date(timeIntervalSinceNow: -220_482.0))
        let validDuration = DateInterval(start: Date(timeIntervalSinceNow: -60), end: Date(timeIntervalSinceNow: 36000))

        let validDayPass = Ticket(name: "Day Pass", duration: validDuration, price: 5.00, validOnAgency: .VTA)
        let validSingleRide = Ticket(name: "Single Ride - 3 Zones", count: 1, price: 9.75, validOnAgency: .CalTrain)
        let expiredMonthly = Ticket(name: "Monthly Pass", duration: expiredDuration, price: 90.00, validOnAgency: .Muni)

        UserManager.shared.addPurchased(ticket: validDayPass)
        UserManager.shared.addPurchased(ticket: expiredMonthly)
        UserManager.shared.addPurchased(ticket: validSingleRide)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        purchasedTicketTableView.reloadData()
    }

    func setUpTicketCarouselView() {
        view.addSubview(ticketCarouselView)
        ticketCarouselView.snp.makeConstraints { (make) -> Void in
            make.leading.equalToSuperview().offset(0)
            make.trailing.equalToSuperview().offset(0)
            make.top.equalTo(view.snp.top).offset(140)
            make.height.equalTo(240)
        }
    }

    func layoutTableView() {
        // MARK: Text Label

        view.addSubview(titleLbl)
        titleLbl.text = "Purchased"
        titleLbl.textColor = UIColor.black
        titleLbl.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLbl.snp.makeConstraints { (make) -> Void in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(ticketCarouselView.snp.bottom).offset(5)
        }

        // MARK: Purchased Ticket tableView

        view.addSubview(purchasedTicketTableView)
        purchasedTicketTableView.snp.makeConstraints { make in
            make.top.equalTo(titleLbl.snp.bottom).offset(5)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
