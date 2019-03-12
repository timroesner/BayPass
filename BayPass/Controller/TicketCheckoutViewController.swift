//
//  TicketCheckoutViewController.swift
//  BayPass
//
//  Created by 凌脩羽 on 3/6/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import UIKit

class TicketCheckoutViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = "Ticket Checkout"
        navigationController?.navigationBar.prefersLargeTitles = false
        
        let ticketView = TicketView(agency: "BART", icon: UIImage(named: "BART")!, cornerRadius: 12)
        view.addSubview(ticketView)
        ticketView.snp.makeConstraints({ (make) -> Void in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(ticketView.snp.width).multipliedBy(0.6)
        })
        ticketView.layoutIfNeeded()
        
        //let ticketTypeDropDown = DropDownMenu(title: "ticket type", items: ["Apple Pay", "Credit/Debit", "Paypal"])
        
    }
}
