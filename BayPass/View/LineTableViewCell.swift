//
//  StationTableViewCell.swift
//  BayPass
//
//  Created by Ayesha Khan on 4/18/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import UIKit

class LineTableViewCell: UITableViewCell {
    var gradient = CAGradientLayer()
    var lineName = UILabel()
    var backView = UIView()
    var iconImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    func setup(with line: Line) {
        addSubview(backView)
        backView.clipsToBounds = true
        backView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        contentView.translatesAutoresizingMaskIntoConstraints = false

        backView.layer.cornerRadius = 12
        backView.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)

        // Gradient
        let leftColor = line.color.lighter(by: 30)
        gradient = CAGradientLayer(leftColor: leftColor ?? #colorLiteral(red: 0.1754914722, green: 0.8503269947, blue: 1, alpha: 1), rightColor: line.color)
        gradient.frame = bounds
        backView.layer.addSublayer(gradient)
        backView.layer.frame = backView.frame
        backView.clipsToBounds = true

        iconImageView.image = line.getIcon()
        iconImageView.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        iconImageView.snp.makeConstraints { make in
            make.size.equalTo(25)
        }
        iconImageView.frame = CGRect(x: 0, y: 0, width: 5, height: 5)
        iconImageView.snp.makeConstraints { _ in
//            make.topMargin.equalToSuperview().offset(5)
//            make.leftMargin.equalTo(snp_left).offset(5)
        }
        backView.addSubview(iconImageView)

        backView.addSubview(lineName)
        lineName.text = "\(line.name) to \(line.destination)"
        lineName.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        lineName.snp.makeConstraints { make in
            make.leftMargin.equalTo(iconImageView.snp_rightMargin).offset(20)
        }
    }

    required init?(coder _: NSCoder) {
        print("NSCoder not supported in PurchasedTicketCell")
        return nil
    }
}
