//
//  ClipperViewController.swift
//  BayPass
//
//  Created by Tim Roesner on 10/18/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

import UIKit

class ClipperViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Clipper"

        // button to add cash value page
        let button = UIButton()
        button.frame = CGRect(x: 7, y: 750, width: 400, height: 50)
        button.backgroundColor = UIColor(hex: 0x120345)
        button.setTitle("add cash value", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        view.addSubview(button)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    @objc func buttonAction(sender _: UIButton!) {
        navigationController?.pushViewController(ClipperAddCashViewController(), animated: true)
    }
}
