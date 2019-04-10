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
    // var title = ""
    let dropDown1 = DropDownMenu(title: "ticket type", items: ["Day Pass", "3 Day Pass", "Monthly Pass"])
    let dropDown2 = DropDownMenu(title: "from", items: ["Zone 1", "Zone 2", "Zone 3", "Zone 4", "Zone 5", "Zone 6", "Zone 7"])
    let dropDown3 = DropDownMenu(title: "to", items: ["Zone 1", "Zone 2", "Zone 3", "Zone 4", "Zone 5", "Zone 6", "Zone 7"])
    let dropDown4 = DropDownMenu(title: "payment method", items: ["Apple Pay", "Credit/Debit", "Paypal", "Venmo"])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //title = "test"
        view.backgroundColor = .white
        //navigationController?.navigationBar.prefersLargeTitles = false

        // let ticketTypeDropDown = DropDownMenu(title: "ticket type", items: ["Apple Pay", "Credit/Debit", "Paypal"])
        
    }

    func setUpTitle(newTitle: String) {
        title = newTitle
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    func setUpTicketView(newTicketView: TicketView) {
        view.addSubview(newTicketView)
        view.addSubview(dropDown1)
        view.addSubview(dropDown2)
        view.addSubview(dropDown3)
        view.addSubview(dropDown4)
        
        newTicketView.snp.makeConstraints({ (make) -> Void in
            //make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(newTicketView.snp.width).multipliedBy(0.6)
            make.bottom.equalTo(dropDown1.snp.top).offset(-20)
        })
        newTicketView.layoutIfNeeded()
        
        
        dropDown1.snp.makeConstraints({ (make) -> Void in
            make.top.equalTo(newTicketView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.bottom.equalTo(dropDown2.snp.top).offset(-20)
        })
        
        
        dropDown2.snp.makeConstraints({ (make) -> Void in
            //make.top.equalTo(dropDown1.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.bottom.equalTo(dropDown3.snp.top).offset(-20)
        })
        
        dropDown3.snp.makeConstraints({ (make) -> Void in
            //make.top.equalTo(dropDown2.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.bottom.equalTo(dropDown4.snp.top).offset(-20)
        })
        
        dropDown4.snp.makeConstraints({ (make) -> Void in
            //make.top.equalTo(dropDown3.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.bottom.equalTo(self.view.snp.bottomMargin).inset(120)
            //make.bottom.equalToSuperview().offset(-150)
        })
        
        //let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        //dropDown4.addGestureRecognizer(tap)
    }
    
    /*
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.3) {
            self.dropDown3.snp.updateConstraints { (make) in
                if(self.dropDown4.isOpen){
                    make.bottom.equalTo(self.dropDown4.snp.top).offset(-20)
                }else{
                    make.bottom.equalTo(self.dropDown4.snp.top).offset(-20)
                }
            }
            self.view.layoutIfNeeded()
        }
    }*/

    func setUpButton(color: String) {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "dark\(color)") ?? UIColor(hex: 0x000)
        button.layer.cornerRadius = 10
        button.setTitle("Pay $xx.xx", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        // button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        view.addSubview(button)
        button.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.view.snp.bottomMargin).inset(20)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(self.view.snp.width).multipliedBy(0.15)
        }
    }
}
