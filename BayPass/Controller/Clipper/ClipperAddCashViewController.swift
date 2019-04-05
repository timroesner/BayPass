//
//  ClipperAddCashViewController.swift
//  BayPass
//
//  Created by 凌脩羽 on 3/6/19.
//  Implemented by Tim on 4/5/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import UIKit
import SnapKit

class ClipperAddCashViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    func setupView() {
        guard let clipperCard = ClipperManager.shared.getClipperCard() else {
            displayAlert(title: "No card found", msg: "You don't have a Clipper card saved yet", dismissAfter: true)
            return
        }
        
        
    }
}
