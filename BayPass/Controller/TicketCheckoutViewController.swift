//
//  TicketCheckoutViewController.swift
//  BayPass
//
//  Created by 凌脩羽 on 3/6/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import UIKit



class TicketCheckoutViewController: UIViewController {
    
    
    var ticket = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = "Ticket Checkout"
        navigationController?.navigationBar.prefersLargeTitles = false
        
        //ticket view
        let ticketView = TicketView(agency: "CalTrain", icon: UIImage(named: "CalTrain")!, cornerRadius: 12)
        view.addSubview(ticketView)
        ticketView.snp.makeConstraints({ (make) -> Void in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(ticketView.snp.width).multipliedBy(0.6)
        })
        ticketView.layoutIfNeeded()
        
        //let ticketTypeDropDown = DropDownMenu(title: "ticket type", items: ["Apple Pay", "Credit/Debit", "Paypal"])
        
        // pay button
        let button = UIButton()
        button.backgroundColor = UIColor(red: 221, green: 84, blue: 65)
        button.layer.cornerRadius = 10
        button.setTitle("Pay $xx.xx", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        //button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        view.addSubview(button)
        button.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.view.snp.bottomMargin).inset(20)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(self.view.snp.width).multipliedBy(0.15)
        }
    }
}

