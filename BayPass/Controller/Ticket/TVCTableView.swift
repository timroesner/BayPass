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
        if purchasedTickets.isEmpty {
            tableView.backgroundView = EmptyView(text: "You have not purchased any tickets yet")
        } else {
            tableView.backgroundView = nil
        }
        return purchasedTickets.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = purchasedTicketTableView.dequeueReusableCell(withIdentifier: purchasedTicketTableViewCellID) as! PurchasedTicketCell
        cell.setup(with: purchasedTickets[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let ticketDetailViewController = TicketDetailViewController(ticket: purchasedTickets[indexPath.row])
        bottomSheet.viewControllers = [ticketDetailViewController]
        bottomSheet.modalPresentationStyle = .overCurrentContext
        present(bottomSheet, animated: true, completion: nil)
        bottomSheet.moveOverlay(toNotchAt: 1, animated: true)
    }
}
