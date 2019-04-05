//
//  StationOverViewViewController.swift
//  BayPass
//
//  Created by Ayesha Khan on 4/4/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import UIKit

class StationOverViewViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        // Do any additional setup after loading the view.
    }

    func setupViews() {
        let moveIndicator = MoveIndicator()
        view.addSubview(moveIndicator)
        moveIndicator.setConstraints()
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}
