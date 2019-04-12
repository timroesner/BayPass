//
//  BayPassButton.swift
//  BayPass
//
//  Created by Tim Roesner on 3/28/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import UIKit

class BayPassButton: UIButton {
    init(title: String, color: UIColor) {
        super.init(frame: CGRect.zero)
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        layer.backgroundColor = color.cgColor
        layer.cornerRadius = 10
    }

    required init?(coder _: NSCoder) {
        print("NSCoder not supported in BayPassButton")
        return nil
    }
}
