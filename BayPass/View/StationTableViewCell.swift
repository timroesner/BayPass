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
    var color = UIColor()
    lazy var backView: UIView = {
        let view = UIView(frame: CGRect(x: 10, y: 6, width: self.frame.width - 5, height: 50))
        return view
    }()

    lazy var iconImage: UIImageView = {
        let image = UIImageView()
        return image
    }()

    lazy var stationName: UILabel = {
        let name = UILabel()
        return name
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
        backView.layer.cornerRadius = 12
        let leftColor = color.lighter(by: 30)
        let rightColor = color.darker(by: 15)
        gradient = CAGradientLayer(leftColor: leftColor ?? #colorLiteral(red: 0.1754914722, green: 0.8503269947, blue: 1, alpha: 1), rightColor: color ?? #colorLiteral(red: 0.2901960784, green: 0.5647058824, blue: 0.8862745098, alpha: 1))
        gradient.cornerRadius = 12
        gradient.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        gradient.frame = backView.frame
        backView.layoutSublayers(of: gradient)
        layer.addSublayer(gradient)
        backView.layer.insertSublayer(gradient, at: 0)
//        backView.backgroundColor = color
        backView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        addSubview(backView)
        backView.addSubview(stationName)
    }
}
