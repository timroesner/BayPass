//
//  ProgressHUD.swift
//  BayPass
//
//  Created by Tim Roesner on 4/1/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import SnapKit
import UIKit

class ProgressHUD: UIView {
    private let activity = UIActivityIndicatorView(style: .whiteLarge)

    init() {
        super.init(frame: CGRect.zero)
        layer.backgroundColor = UIColor(red: 0.66, green: 0.66, blue: 0.66, alpha: 0.6).cgColor
        layer.cornerRadius = 8

        activity.startAnimating()
        addSubview(activity)
        activity.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.top.left.right.bottom.equalToSuperview().inset(8)
        }
    }

    override func didMoveToSuperview() {
        if superview != nil {
            snp.makeConstraints { make in
                make.center.equalToSuperview()
                make.width.height.equalTo(100)
            }
        }
    }

    func stop() {
        activity.stopAnimating()
        removeFromSuperview()
    }

    required init?(coder _: NSCoder) {
        print("NSCoder not supported in Progress HUD")
        return nil
    }
}
