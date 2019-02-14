//
//  ClipperViewController.swift
//  BayPass
//
//  Created by Tim Roesner on 10/18/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

import SnapKit
import UIKit

class ClipperViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addLabel(title: "Clipper")

        let clipperView = ClipperView(cardNumber: 123_456_789, cashValue: 12.54)
        view.addSubview(clipperView)

        clipperView.snp.makeConstraints({ (make) -> Void in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(clipperView.snp.width).multipliedBy(0.6)
        })
        clipperView.layoutIfNeeded()
    }
}
