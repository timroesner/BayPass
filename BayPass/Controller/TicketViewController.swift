//
//  TicketViewController.swift
//  BayPass
//
//  Created by Tim Roesner on 10/18/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

import CoreLocation
import UIKit
import SnapKit

class TicketViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let scrollView = UIScrollView()
    let titleLbl = UILabel()
    let purchesedTicketView = UIView()
    var purchasedTicketTableView: UITableView = {
        let tableView = UITableView()
        tableView.isScrollEnabled = true
        return tableView
    }()
    
    let agencies = ["BART", "CalTrain", "ACE", "ACTransit", "MUNI"]
    let icons = ["BART", "CalTrain", "CalTrain", "Bus", "Bus"]
    
    private var tickets : [Ticket] = []
    private let cellID = "cellID"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Tickets"

        //scroll view
        view.addSubview(scrollView)
        scrollView.frame = CGRect(x: 0, y: 140, width: view.frame.size.width, height: 240)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.backgroundColor = UIColor.white
        let padding : CGFloat = 10
        let viewWidth = CGFloat(135)
        
        var x : CGFloat = 0
        for i in 0...agencies.count - 1 {
            let view: UIView = UIView(frame: CGRect(x: x + (i == 0 ? 20 : 10), y: 20, width: viewWidth, height: 200))
            view.backgroundColor = UIColor.white
            scrollView.addSubview(view)
            
            let ticketView = TicketView(agency: agencies[i], icon: UIImage(named: icons[i])!, cornerRadius: 12)
            view.addSubview(ticketView)
            let tap = UITapGestureRecognizer(target: self, action: #selector(buttonAction))
            ticketView.isUserInteractionEnabled = true
            ticketView.addGestureRecognizer(tap)
            ticketView.snp.makeConstraints({ (make) -> Void in
                make.width.equalTo(135)
                make.height.equalTo(200)
            })
            ticketView.layoutIfNeeded()
            
            x = view.frame.origin.x + viewWidth + padding
        }
        scrollView.contentSize = CGSize(width: x + padding, height: scrollView.frame.size.height)
        
        
        //text label
        view.addSubview(titleLbl)
        titleLbl.text = "Purchased"
        titleLbl.textColor = UIColor.black
        titleLbl.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLbl.snp.makeConstraints({ (make) -> Void in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(scrollView.snp.bottom).offset(10)
        })
        
        
        //purchased ticket view
        view.addSubview(purchesedTicketView)
        purchesedTicketView.snp.makeConstraints({ (make) -> Void in
            make.width.equalToSuperview()
            make.top.equalTo(titleLbl.snp.bottom).offset(10)
            make.bottom.equalTo(view.snp.bottom).offset(-100)
        })
        
        purchesedTicketView.addSubview(purchasedTicketTableView)
        purchasedTicketTableView.frame.size = CGSize(width: view.frame.width, height: 300)
        purchasedTicketTableView.rowHeight = 93.0
        purchasedTicketTableView.dataSource = self
        purchasedTicketTableView.delegate = self
        purchasedTicketTableView.register(PurchasedTicketCell.self, forCellReuseIdentifier: cellID)
        
        //temporary data
        let loc: CLLocation = CLLocation(latitude: 21.35, longitude: 121.34)
        let station = Station(name: "SFO", code: 2, transitModes: [TransitMode.bart], lines: ["Green"], location: loc)
        let line = Line(name: "Green", code: 2, destination: "Milbrae", stops: [station])
        let calTrain = Agency(name: "CalTrain", routes: [line], icon: UIImage(named: "CalTrain")!)
        let acTransit = Agency(name: "ACTransit", routes: [line], icon: UIImage(named: "Bus")!)
        let ace = Agency(name: "ACE", routes: [line], icon: UIImage(named: "CalTrain")!)
        let solTrans = Agency(name: "SolTrans", routes: [line], icon: UIImage(named: "Bus")!)
        let locations = [loc]
        let dur = DateInterval(start: Date(timeIntervalSince1970: 60), duration: 30)
        let ticket1 = Ticket(name: "Monthly Pass", duration: dur, price: 2.3, validOnAgency: calTrain, NFCCode: "234", locations: locations)
        let ticket2 = Ticket(name: "Weekly Pass", duration: dur, price: 2.3, validOnAgency: acTransit, NFCCode: "234", locations: locations)
        let ticket3 = Ticket(name: "Weekly Pass", duration: dur, price: 2.3, validOnAgency: solTrans, NFCCode: "234", locations: locations)
        let ticket4 = Ticket(name: "Monthly Pass", duration: dur, price: 2.3, validOnAgency: ace, NFCCode: "234", locations: locations)
        tickets = [ticket1, ticket2, ticket3, ticket4]
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    @objc func buttonAction(sender : UITapGestureRecognizer!) {
        //TicketSelectionDelegate.ticketPressed(ticketName: sender.ticketName)
        navigationController?.pushViewController(TicketCheckoutViewController(), animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tickets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = purchasedTicketTableView.dequeueReusableCell(withIdentifier: cellID) as! PurchasedTicketCell
        cell.setup(with: tickets[indexPath.row])
        return cell
    }
    
}
