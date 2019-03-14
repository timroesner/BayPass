//
//  MoveIndicator.swift
//  BayPass
//
//  Created by Tim Roesner on 2/28/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import SnapKit
import UIKit

class MoveIndicator: UIView {
    init() {
        super.init(frame: CGRect.zero)
        layer.backgroundColor = UIColor().lightGrey.cgColor
        layer.cornerRadius = 3
    }

    func setConstraints() {
        snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.centerX.equalToSuperview()
            make.height.equalTo(5)
            make.width.equalTo(36)
        }
    }

    required init?(coder _: NSCoder) {
        print("NSCoder not supported in MoveIndicator")
        return nil
    }
}
