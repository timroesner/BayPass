//
//  TicketViewController.swift
//  BayPass
//
//  Created by Tim Roesner on 10/18/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

import UIKit

class TicketViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "Tickets"
        self.navigationController?.navigationBar.prefersLargeTitles = true

        // button to ticket checkout page
        let button = UIButton();
        button.frame =  CGRect(x: 7, y: 750, width: 400, height: 50)
        button.backgroundColor = UIColor(red: 221, green: 84, blue: 65)
        button.setTitle("ticket checkout", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        self.navigationController?.pushViewController(TicketCheckoutViewController(), animated: true)
    }
}
