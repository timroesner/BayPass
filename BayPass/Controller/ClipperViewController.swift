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
        self.title = "Clipper"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        // button to add cash value page
        let button = UIButton();
        button.frame =  CGRect(x: 7, y: 750, width: 400, height: 50)
        button.backgroundColor = UIColor(red: 12, green: 63, blue: 106)
        button.setTitle("add cash value", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        self.navigationController?.pushViewController(ClipperAddCashViewController(), animated: true)
    }
}
