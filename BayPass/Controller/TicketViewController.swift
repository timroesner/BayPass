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

    let purchesedTicketView = UIView()
    var purchasedTicketTableView: UITableView = {
        let tableView = UITableView()
        tableView.isScrollEnabled = true
        return tableView
    }()

    private let purchasedTicketTableViewCellID = "purchasedTicketTableViewCellID"

    let agencies = Agency.allCases

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Tickets"

        ticketCarouselView.delegate = self
        ticketCarouselView.dataSource = self
        ticketCarouselView.register(ticketCarouselViewCell.self, forCellWithReuseIdentifier: ticketCarouselViewCellID)
        view.addSubview(ticketCarouselView)
        setUpTicketCarouselView()

        // MARK: Text Label

        view.addSubview(titleLbl)
        titleLbl.text = "Purchased"
        titleLbl.textColor = UIColor.black
        titleLbl.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLbl.snp.makeConstraints { (make) -> Void in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(ticketCarouselView.snp.bottom).offset(10)
        }

        // MARK: Purchased Ticket view

        view.addSubview(purchesedTicketView)
        purchesedTicketView.snp.makeConstraints { (make) -> Void in
            make.width.equalToSuperview()
            make.top.equalTo(titleLbl.snp.bottom).offset(10)
            make.bottom.equalTo(self.view.snp.bottomMargin).inset(20)
        }

        purchesedTicketView.addSubview(purchasedTicketTableView)
        purchasedTicketTableView.snp.makeConstraints { make in
            make.top.equalTo(titleLbl.snp.bottom).offset(8)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        purchasedTicketTableView.rowHeight = 93.0
        purchasedTicketTableView.dataSource = self
        purchasedTicketTableView.delegate = self
        purchasedTicketTableView.register(PurchasedTicketCell.self, forCellReuseIdentifier: purchasedTicketTableViewCellID)

        // MARK: temporary data

        let expiredDuration = DateInterval(start: Date(timeIntervalSinceNow: -470_482.0), end: Date(timeIntervalSinceNow: -220_482.0))
        let validDuration = DateInterval(start: Date(timeIntervalSinceNow: -470_482.0), end: Date(timeIntervalSinceNow: 470_482.0))

        let expiredTicket = Ticket(name: "Monthly Pass", duration: expiredDuration, price: 2.3, validOnAgency: Agency.CalTrain)
        let validTicket1 = Ticket(name: "Weekly Pass", duration: validDuration, price: 2.3, validOnAgency: Agency.ACTransit)
        let validTicket2 = Ticket(name: "Weekly Pass", duration: validDuration, price: 2.3, validOnAgency: Agency.SolTrans)
        let validTicket3 = Ticket(name: "Monthly Pass", duration: validDuration, price: 2.3, validOnAgency: Agency.ACE)

        UserManager.shared.addPurchased(ticket: expiredTicket)
        UserManager.shared.addPurchased(ticket: validTicket1)
        UserManager.shared.addPurchased(ticket: validTicket2)
        UserManager.shared.addPurchased(ticket: validTicket3)
    }

    func setUpTicketCarouselView() {
        ticketCarouselView.snp.makeConstraints { (make) -> Void in
            make.leading.equalToSuperview().offset(0)
            make.trailing.equalToSuperview().offset(0)
            make.top.equalTo(view.snp.top).offset(140)
            make.height.equalTo(240)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension TicketViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return agencies.count
    }

    func collectionView(_: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = ticketCarouselView.dequeueReusableCell(withReuseIdentifier: ticketCarouselViewCellID, for: indexPath) as! ticketCarouselViewCell
        cell.backgroundColor = .white
        cell.setup(with: TicketView(agency: agencies[indexPath.row].stringValue, icon: agencies[indexPath.row].getIcon(), cornerRadius: 12))
        return cell
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        return CGSize(width: 135, height: 200)
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, insetForSectionAt _: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    }

    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let ticketCheckoutViewController = TicketCheckoutViewController()
        ticketCheckoutViewController.agency = agencies[indexPath.row]
        navigationController?.pushViewController(ticketCheckoutViewController, animated: true)
    }
}

extension TicketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return UserManager.shared.getPurchasedTickets().count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = purchasedTicketTableView.dequeueReusableCell(withIdentifier: purchasedTicketTableViewCellID) as! PurchasedTicketCell
        cell.setup(with: UserManager.shared.getPurchasedTickets()[indexPath.row])
        return cell
    }
}
