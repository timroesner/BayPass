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
        addLabel(title: "Clipper")
        
        
        let clipperView = ClipperView(agency: "Clipper", icon: #imageLiteral(resourceName: "ClipperLogoVertical"), cornerRadius: 12, cardNumber: "**** 6817")
        view.addSubview(clipperView)
        
        clipperView.snp.makeConstraints({ (make) -> Void in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(350)
            make.height.equalTo(200)
        })
        
    }
}
