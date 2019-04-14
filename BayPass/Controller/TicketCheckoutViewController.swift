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
    var agency = Agency.zero
    let dropDown1 = DropDownMenu(title: "ticket type", items: ["Day Pass", "3 Day Pass", "Monthly Pass"])
    let dropDown2 = DropDownMenu(title: "from", items: ["Zone 1", "Zone 2", "Zone 3", "Zone 4", "Zone 5", "Zone 6", "Zone 7"])
    let dropDown3 = DropDownMenu(title: "to", items: ["Zone 1", "Zone 2", "Zone 3", "Zone 4", "Zone 5", "Zone 6", "Zone 7"])
    let dropDown4 = DropDownMenu(title: "payment method", items: ["Apple Pay", "Credit/Debit", "Paypal", "Venmo"])

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        title = agency.stringValue
        navigationController?.navigationBar.prefersLargeTitles = false
        setUpTicketView(newTicketView: TicketView(agency: agency.stringValue, icon: agency.getIcon(), cornerRadius: 12))
        setUpButton(color: UIColor(named: "dark\(agency.stringValue.replacingOccurrences(of: " ", with: ""))") ?? UIColor.black)
    }

    func setUpTicketView(newTicketView: TicketView) {
        view.addSubview(newTicketView)
        view.addSubview(dropDown1)
        view.addSubview(dropDown2)
        view.addSubview(dropDown3)
        view.addSubview(dropDown4)

        newTicketView.snp.makeConstraints { (make) -> Void in
            // make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(newTicketView.snp.width).multipliedBy(0.6)
            make.bottom.equalTo(dropDown1.snp.top).offset(-20)
        }
        newTicketView.layoutIfNeeded()

        dropDown1.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(newTicketView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.bottom.equalTo(dropDown2.snp.top).offset(-20)
        }

        dropDown2.snp.makeConstraints { (make) -> Void in
            // make.top.equalTo(dropDown1.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.bottom.equalTo(dropDown3.snp.top).offset(-20)
        }

        dropDown3.snp.makeConstraints { (make) -> Void in
            // make.top.equalTo(dropDown2.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.bottom.equalTo(dropDown4.snp.top).offset(-20)
        }

        dropDown4.snp.makeConstraints { (make) -> Void in
            // make.top.equalTo(dropDown3.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            // make.bottom.equalTo(self.view.snp.bottomMargin).offset(-120)
            make.bottom.equalTo(self.view.snp.bottomMargin).multipliedBy(0.82)
            // make.bottom.equalToSuperview().offset(-150)
            // make.bottom.equalTo(self.view.snp.bottomMargin).offset()
        }

        /*
         dropDown4.tableView.snp.makeConstraints({ (make) -> Void in
             make.bottom.equalTo(self.view.snp.bottomMargin).offset(-120).priorityRequired()
         })*/
    }

    func setUpButton(color: UIColor) {
        let payButton = BayPassButton(title: "Pay $xx.xx", color: color)
        payButton.addTarget(self, action: #selector(pay), for: .touchUpInside)
        view.addSubview(payButton)
        payButton.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.view.snp.bottomMargin).inset(20)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(self.view.snp.width).multipliedBy(0.15)
        }
    }

    @objc func pay() {
        print("pay")
    }
}
