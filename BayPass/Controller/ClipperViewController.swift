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
        title = "Clipper"

        let clipperView = ClipperView(cardNumber: 123_456_789, cashValue: 12.54)
        view.addSubview(clipperView)

        clipperView.snp.makeConstraints({ (make) -> Void in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(clipperView.snp.width).multipliedBy(0.6)
        })
        clipperView.layoutIfNeeded()

        // button to add cash value page
        let button = UIButton()
        button.backgroundColor = UIColor(red: 12, green: 63, blue: 106)
        button.layer.cornerRadius = 10
        button.setTitle("Add Cash Value", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        view.addSubview(button)

        // Make SnapKit contraints for button here
        button.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.view.snp.bottomMargin).inset(20)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(self.view.snp.width).multipliedBy(0.15)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    @objc func buttonAction(sender _: UIButton!) {
        navigationController?.pushViewController(ClipperAddCashViewController(), animated: true)
    }
}
