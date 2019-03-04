//
//  CustomTextField.swift
//  BayPass
//
//  Created by Tim Roesner on 3/2/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import UIKit

class CustomTextField: UIView {
    
    let textField = UITextField()
    
    init (title: String, placeholder: String) {
        super.init(frame: CGRect.zero)
        
        let titleLabel = UILabel()
        titleLabel.text = title.uppercased()
        titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        titleLabel.textColor = UIColor(red: 164, green: 164, blue: 164)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.width.equalTo(36)
            make.left.equalToSuperview().offset(8)
            make.top.equalToSuperview().inset(11)
            make.bottom.equalToSuperview().inset(13)
        }
        
        textField.placeholder = placeholder
        textField.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleLabel)
            make.height.equalTo(22)
            make.left.equalTo(titleLabel.snp.right).offset(8)
            make.right.equalToSuperview()
        }
        
        let line = UILabel()
        line.backgroundColor = UIColor(red: 227, green: 227, blue: 227)
        addSubview(line)
        line.snp.makeConstraints { (make) in
            make.top.equalTo(textField.snp.bottom).offset(8)
            make.bottom.equalToSuperview()
            make.height.equalTo(1.5)
            make.left.equalTo(titleLabel)
            make.right.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoder has not been implemented for CustomTextField")
    }
}
