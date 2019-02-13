//
//  ViewController.swift
//  BayPass
//
//  Created by Tim Roesner on 9/14/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addLabel(title: "Map")

        let ticketView = TicketView(agency: "ACE", icon: #imageLiteral(resourceName: "Bus"), cornerRadius: 12)
        view.addSubview(ticketView)

        ticketView.snp.makeConstraints({ (make) -> Void in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(260)
            make.height.equalTo(150)
        })
    }
}
