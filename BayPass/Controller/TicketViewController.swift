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

    private var tickets: [Ticket] = []
    private let purchasedTicketTableViewCellID = "purchasedTicketTableViewCellID"

    let agencies = ["BART", "CalTrain", "ACE", "ACTransit", "MUNI"]
    let icons = ["BART", "CalTrain", "CalTrain", "Bus", "Bus"]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Tickets"

        ticketCarouselView.delegate = self
        ticketCarouselView.dataSource = self
        ticketCarouselView.register(ticketCarouselViewCell.self, forCellWithReuseIdentifier: ticketCarouselViewCellID)
        view.addSubview(ticketCarouselView)
        //ticketCarouselView.frame = CGRect(x: 0, y: 140, width: view.frame.size.width, height: 240)
        setUpTicketCarouselView()

        //text label
        view.addSubview(titleLbl)
        titleLbl.text = "Purchased"
        titleLbl.textColor = UIColor.black
        titleLbl.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLbl.snp.makeConstraints({ (make) -> Void in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(ticketCarouselView.snp.bottom).offset(10)
        })

        // purchased ticket view
        view.addSubview(purchesedTicketView)
        purchesedTicketView.snp.makeConstraints({ (make) -> Void in
            make.width.equalToSuperview()
            make.top.equalTo(titleLbl.snp.bottom).offset(10)
            make.bottom.equalTo(self.view.snp.bottomMargin).inset(20)
        })

        purchesedTicketView.addSubview(purchasedTicketTableView)
        purchasedTicketTableView.frame.size = CGSize(width: view.frame.width, height: view.frame.height)
        purchasedTicketTableView.rowHeight = 93.0
        purchasedTicketTableView.dataSource = self
        purchasedTicketTableView.delegate = self
        purchasedTicketTableView.register(PurchasedTicketCell.self, forCellReuseIdentifier: purchasedTicketTableViewCellID)

        //temporary data
        let loc: CLLocation = CLLocation(latitude: 21.35, longitude: 121.34)
        let station = Station(name: "SFO", code: 2, transitModes: [TransitMode.bart], lines: ["Green"], location: loc)
        let line = Line(name: "Green", code: 2, destination: "Milbrae", stops: [station])
        let calTrain = Agency.CalTrain
        let acTransit = Agency.ACTransit
        let ace = Agency.ACE
        let solTrans = Agency.SolTrans
        let locations = [loc]
        let dur = DateInterval(start: Date(timeIntervalSince1970: 60), duration: 30)
        let ticket1 = Ticket(name: "Monthly Pass", duration: dur, price: 2.3, validOnAgency: calTrain)
        let ticket2 = Ticket(name: "Weekly Pass", duration: dur, price: 2.3, validOnAgency: acTransit)
        let ticket3 = Ticket(name: "Weekly Pass", duration: dur, price: 2.3, validOnAgency: solTrans)
        let ticket4 = Ticket(name: "Monthly Pass", duration: dur, price: 2.3, validOnAgency: ace)
        tickets = [ticket1, ticket2, ticket3, ticket4]
    }

    func setUpTicketCarouselView() {
        /* ticketCarouselView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
         ticketCarouselView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
         ticketCarouselView.heightAnchor.constraint(equalToConstant: 240).isActive = true
         ticketCarouselView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true */
        ticketCarouselView.snp.makeConstraints({ (make) -> Void in
            make.leading.equalToSuperview().offset(0)
            make.trailing.equalToSuperview().offset(0)
            make.top.equalTo(view.snp.top).offset(140)
            make.height.equalTo(240)
        })
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    /*
    @objc func buttonAction(sender _: UITapGestureRecognizer!) {
        // TicketSelectionDelegate.ticketPressed(ticketName: sender.ticketName)
        navigationController?.pushViewController(TicketCheckoutViewController(), animated: true)
    }*/
}

extension TicketViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return agencies.count
    }

    func collectionView(_: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = ticketCarouselView.dequeueReusableCell(withReuseIdentifier: ticketCarouselViewCellID, for: indexPath) as! ticketCarouselViewCell
        cell.backgroundColor = .white
        // cell.ticketView = TicketView(agency: agencies[indexPath.row], icon: UIImage(named: icons[indexPath.row])!, cornerRadius: 12)
        cell.setup(with: TicketView(agency: agencies[indexPath.row], icon: UIImage(named: icons[indexPath.row])!, cornerRadius: 12))
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
        ticketCheckoutViewController.setUpTitle(newTitle: agencies[indexPath.row])
        ticketCheckoutViewController.setUpTicketView(newTicketView: TicketView(agency: agencies[indexPath.row], icon: UIImage(named: icons[indexPath.row])!, cornerRadius: 12))
        ticketCheckoutViewController.setUpButton(color: agencies[indexPath.row])
        navigationController?.pushViewController(ticketCheckoutViewController, animated: true)
    }
}

extension TicketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return tickets.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = purchasedTicketTableView.dequeueReusableCell(withIdentifier: purchasedTicketTableViewCellID) as! PurchasedTicketCell
        cell.setup(with: tickets[indexPath.row])
        return cell
    }
}

class ticketCarouselViewCell: UICollectionViewCell {
    var ticketView = TicketView(agency: "ACE", icon: UIImage(named: "CalTrain")!, cornerRadius: 12)

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    func setup(with newTicketView: TicketView) {
        ticketView = newTicketView
        addSubview(ticketView)
        ticketView.snp.makeConstraints({ (make) -> Void in
            make.width.equalTo(135)
            make.height.equalTo(200)
        })
        ticketView.layoutIfNeeded()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
