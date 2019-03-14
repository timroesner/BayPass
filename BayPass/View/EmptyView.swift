//
//  EmptyView.swift
//  BayPass
//
//  Created by Tim Roesner on 3/1/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import SnapKit
import UIKit

class EmptyView: UIView {
    init(text: String) {
        super.init(frame: CGRect.zero)

        let label = UILabel()
        label.text = text
        label.numberOfLines = 0
        label.textColor = UIColor().lightGrey
        addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    required init?(coder _: NSCoder) {
        print("NSCoder not supported in EmptyView")
        return nil
    }
}
