//
//  TVCTableView.swift
//  BayPass
//
//  Created by Tim Roesner on 4/14/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import UIKit

extension TicketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection _: Int) -> Int {
        let tickets = UserManager.shared.getPurchasedTickets()
        if tickets.isEmpty {
            tableView.backgroundView = EmptyView(text: "You have not purchased any tickets yet")
        } else {
            tableView.backgroundView = nil
        }
        return tickets.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = purchasedTicketTableView.dequeueReusableCell(withIdentifier: purchasedTicketTableViewCellID) as! PurchasedTicketCell
        cell.setup(with: UserManager.shared.getPurchasedTickets()[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let ticketDetailViewController = TicketDetailViewController()
        ticketDetailViewController.ticket = UserManager.shared.getPurchasedTickets()[indexPath.row]
        navigationController?.pushViewController(ticketDetailViewController, animated: true)
    }
}
