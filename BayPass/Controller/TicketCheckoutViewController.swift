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
    //var title = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //title = "test"
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        
        //let ticketTypeDropDown = DropDownMenu(title: "ticket type", items: ["Apple Pay", "Credit/Debit", "Paypal"])
    }
    
    func setUpTitle(newTitle: String){
        title = newTitle
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func setUpTicketView(newTicketView: TicketView){
        view.addSubview(newTicketView)
        newTicketView.snp.makeConstraints({ (make) -> Void in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(newTicketView.snp.width).multipliedBy(0.6)
        })
        newTicketView.layoutIfNeeded()
    }
    
    func setUpButton(color: String){
        let button = UIButton()
        button.backgroundColor = UIColor(named: "dark\(color)") ?? UIColor(hex: 0x000)
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

