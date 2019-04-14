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

    let agencies = Agency.allCases

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
        purchasedTicketTableView.register(PurchasedTicketCell.self, forCellReuseIdentifier: purchasedTicketTableViewCellID)
        layoutTableView()

        // MARK: temporary data
        UserManager.shared.clearAllPurchasedTickets()
        let expiredDuration = DateInterval(start: Date(timeIntervalSinceNow: -470_482.0), end: Date(timeIntervalSinceNow: -220_482.0))
        let validDuration = DateInterval(start: Date(timeIntervalSinceNow: -470_482.0), end: Date(timeIntervalSinceNow: 470_482.0))

        let expiredTicket = Ticket(name: "Monthly Pass", duration: expiredDuration, price: 2.3, validOnAgency: Agency.CalTrain)
        let validTicket1 = Ticket(name: "Weekly Pass", duration: validDuration, price: 2.3, validOnAgency: Agency.ACTransit)
        let validTicket2 = Ticket(name: "Weekly Pass", duration: validDuration, price: 2.3, validOnAgency: Agency.SolTrans)
        let validTicket3 = Ticket(name: "Monthly Pass", duration: validDuration, price: 2.3, validOnAgency: Agency.ACE)
        let validSingleRide = Ticket(name: "Single Ride", count: 1, price: 2.50, validOnAgency: Agency.VTA)

        UserManager.shared.addPurchased(ticket: expiredTicket)
        UserManager.shared.addPurchased(ticket: validTicket1)
        UserManager.shared.addPurchased(ticket: validTicket2)
        UserManager.shared.addPurchased(ticket: validTicket3)
        UserManager.shared.addPurchased(ticket: validSingleRide)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
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
            make.top.equalTo(ticketCarouselView.snp.bottom).offset(10)
        }
        
        // MARK: Purchased Ticket tableView
        view.addSubview(purchasedTicketTableView)
        purchasedTicketTableView.snp.makeConstraints { make in
            make.top.equalTo(titleLbl.snp.bottom).offset(8)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
