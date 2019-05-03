//
//  StationTableViewCell.swift
//  BayPass
//
//  Created by Ayesha Khan on 4/18/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import UIKit

class StationTableViewCell: UITableViewCell {
    var gradient = CAGradientLayer()
    var stationName = UILabel()
    var backView = UIView()
    var iconImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    /*
     lazy var backView: UIView = {
     let view = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 50))
     return view
     }()

     lazy var stationName: UILabel = {
     let name = UILabel()
     return name
     }()*/

    func setup(with line: Line) {
        addSubview(backView)
        backView.clipsToBounds = true
        backView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(2)
            make.bottom.equalToSuperview().offset(2)
            make.left.equalToSuperview().offset(2)
            make.right.equalToSuperview().offset(2)
        }
        contentView.translatesAutoresizingMaskIntoConstraints = false

        backView.layer.cornerRadius = 12

        // Gradient
        let leftColor = line.color.lighter(by: 30)
        gradient = CAGradientLayer(leftColor: leftColor ?? #colorLiteral(red: 0.1754914722, green: 0.8503269947, blue: 1, alpha: 1), rightColor: line.color)
        gradient.frame = bounds
        backView.layer.addSublayer(gradient)

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

        backView.addSubview(stationName)
        stationName.text = line.name
        stationName.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        stationName.snp.makeConstraints { make in
            make.leftMargin.equalTo(iconImageView.snp_rightMargin).offset(15)
        }
//
//        backView.addSubview(stationName)
//        stationName.text = line.name
//        stationName.textColor = .black
//        stationName.font = UIFont.systemFont(ofSize: 12, weight: .bold)
//        stationName.snp.makeConstraints { (make) in
//            make.top.equalToSuperview().offset(5)
//            make.leftMargin.equalTo(iconImageView.snp_rightMargin).offset(5)
//        }
    }

    required init?(coder _: NSCoder) {
        print("NSCoder not supported in PurchasedTicketCell")
        return nil
    }
}
