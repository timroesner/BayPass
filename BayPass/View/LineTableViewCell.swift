//
//  StationTableViewCell.swift
//  BayPass
//
//  Created by Ayesha Khan on 4/18/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import UIKit

class LineTableViewCell: UITableViewCell {
    var gradientLayer = CAGradientLayer()
    var lineName = UILabel()
    var backView = UIView()
    var iconImageView = UIImageView()

    override var frame: CGRect {
        get {
            return super.frame
        }
        set(newFrame) {
            var frame = newFrame
            frame.origin.y += 4
            frame.size.height -= 2 * 4
            super.frame = frame
        }
    }

    override func layoutSubviews() {
        gradientLayer.frame = bounds
    }

    override init(style _: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCell.CellStyle.value1, reuseIdentifier: reuseIdentifier)
    }

    func setup(with line: Line) {
        let leftColor = line.color.lighter(by: 30)

        gradientLayer = CAGradientLayer(leftColor: leftColor ?? #colorLiteral(red: 0.1754914722, green: 0.8503269947, blue: 1, alpha: 1), rightColor: line.color)
        gradientLayer.name = "layerName"

        backView.layer.addSublayer(gradientLayer)
        backView.layer.insertSublayer(gradientLayer, at: 0)

        addSubview(backView)
        backView.clipsToBounds = true
        backView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }

        backView.layer.cornerRadius = 12
        backView.clipsToBounds = true
        bounds = bounds.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0))
        iconImageView.image = line.getIcon()
        iconImageView.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        iconImageView.snp.makeConstraints { make in
            make.size.equalTo(25)
        }
        backView.addSubview(iconImageView)

        backView.addSubview(lineName)
        lineName.text = "\(line.name) to \(line.destination)"
        lineName.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        lineName.font = UIFont.boldSystemFont(ofSize: 12)
        lineName.snp.makeConstraints { make in
            make.leftMargin.equalTo(iconImageView.snp_rightMargin).offset(20)
        }
    }

    required init?(coder _: NSCoder) {
        print("NSCoder not supported in LineTableViewCell")
        return nil
    }
}
