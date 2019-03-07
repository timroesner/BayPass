//
//  ViewController.swift
//  BayPass
//
//  Created by Tim Roesner on 9/14/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

import CoreLocation
import MapKit
import SnapKit
import UIKit

class MapViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addLabel(title: "Map")

        // let dropDown = DropDownMenu(title: "Payment method", items: ["Apple Pay", "Credit/Debit", "Paypal", "Venmo", "Paypal", "Venmo"])
        let dropDown = DropDownMenu(title: "PAYMENT METHOD", items: ["Apple Pay", "Credit/Debit", "Paypal"])
        view.addSubview(dropDown)
        dropDown.snp.makeConstraints({ (make) -> Void in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(40)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(60)
        })
    }
}
