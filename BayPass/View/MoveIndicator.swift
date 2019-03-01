//
//  MoveIndicator.swift
//  BayPass
//
//  Created by Tim Roesner on 2/28/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import UIKit
import SnapKit

class MoveIndicator: UIView {

    init() {
        super.init(frame: CGRect.zero)
        layer.backgroundColor = UIColor().lightGrey.cgColor
        layer.cornerRadius = 3
    }
    
    func setConstraints() {
        self.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.centerX.equalToSuperview()
            make.height.equalTo(5)
            make.width.equalTo(36)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
