//
//  SearchFloatView.swift
//  BayPass
//
//  Created by Tim Roesner on 3/2/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import SnapKit
import UIKit

class SearchFloatView: UIView {
    var fromTextField = UITextField()
    var toTextField = UITextField()
    let leaveTimeButton = UIButton()
    let cancelButton = UIButton()

    init(from: String, to: String) {
        super.init(frame: CGRect.zero)

        layer.backgroundColor = UIColor.white.cgColor
        layer.cornerRadius = 14

        let fromView = CustomTextField(title: "From", placeholder: "Location")
        fromTextField = fromView.textField
        fromTextField.autocorrectionType = .no
        fromTextField.text = from
        addSubview(fromView)
        fromView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.left.equalToSuperview().inset(8)
            make.right.equalToSuperview().inset(19)
            make.height.equalTo(38)
        }

        let toView = CustomTextField(title: "To", placeholder: "Destination")
        toTextField = toView.textField
        toTextField.autocorrectionType = .no
        toTextField.text = to
        addSubview(toView)
        toView.snp.makeConstraints { make in
            make.top.equalTo(fromView.snp.bottom).offset(6)
            make.left.equalToSuperview().inset(8)
            make.right.equalToSuperview().inset(19)
            make.height.equalTo(38)
        }

        leaveTimeButton.setTitle("Leaving Soon", for: .normal)
        leaveTimeButton.isUserInteractionEnabled = true
        leaveTimeButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        leaveTimeButton.setTitleColor(UIColor(red: 0, green: 122, blue: 255), for: .normal)
        addSubview(leaveTimeButton)
        leaveTimeButton.snp.makeConstraints { make in
            make.top.equalTo(toView.snp.bottom).offset(7)
            make.bottom.equalToSuperview().inset(7)
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(18)
        }

        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.isUserInteractionEnabled = true
        cancelButton.setTitleColor(UIColor(red: 0, green: 122, blue: 255), for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        addSubview(cancelButton)
        cancelButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(19)
            make.height.equalTo(18)
            make.centerY.equalTo(leaveTimeButton)
        }
    }

    required init?(coder _: NSCoder) {
        print("NSCoder not supported in SearchFloatView")
        return nil
    }
}
