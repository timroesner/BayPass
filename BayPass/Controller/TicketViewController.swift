//
//  TicketViewController.swift
//  BayPass
//
//  Created by Tim Roesner on 10/18/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

import CoreLocation
import UIKit

class TicketViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let cellId = "cellId"
    var tickets: [Pass] = [Pass]()

    let ticketTableView: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        generatePasses()
        setupTableView()
    }

    func setupTableView() {
        view.addSubview(ticketTableView)

        ticketTableView.delegate = self
        ticketTableView.dataSource = self
        ticketTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        ticketTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        ticketTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        ticketTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        ticketTableView.translatesAutoresizingMaskIntoConstraints = false
        ticketTableView.register(PurchesedTicketCell.self, forCellReuseIdentifier: cellId)
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return tickets.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! PurchesedTicketCell
        cell.setup(with: tickets[indexPath.row], agency: "ACE", icon: UIImage(named: "CalTrain")!)
        return cell
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 93
    }

    func generatePasses() {
        let loc: CLLocation = CLLocation(latitude: 21.35, longitude: 121.34)
        let station = Station(name: "SFO", code: 2, transitModes: [TransitMode.bart], lines: ["Green"], location: loc)
        let line = Line(name: "Green", code: 2, destination: "Milbrae", stops: [station])
        let duration = DateInterval(start: Date(timeIntervalSince1970: 60), duration: 45)
        let bart = Agency(name: "BART", routes: [line])
        let vta = Agency(name: "VTA", routes: [line])

        let pass1 = Pass(name: "Monthly Pass", duration: duration, price: 12.25, validOnAgency: bart)
        let pass2 = Pass(name: "3 Day Pass", duration: duration, price: 12.25, validOnAgency: vta)
        let pass3 = Pass(name: "Weekly Pass", duration: duration, price: 17.25, validOnAgency: vta)

        tickets.append(pass1)
        tickets.append(pass2)
        tickets.append(pass3)
    }
}
