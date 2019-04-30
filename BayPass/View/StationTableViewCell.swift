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
        let view = UIView(frame: CGRect(x: 10, y: 6, width: self.frame.width - 20, height: 50))
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
    }

    override func layoutSubviews() {
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
        backView.layer.cornerRadius = 12
        let leftColor = color.lighter(by: 30)
        gradient = CAGradientLayer(leftColor: leftColor ?? #colorLiteral(red: 0.1754914722, green: 0.8503269947, blue: 1, alpha: 1), rightColor: color)
        gradient.frame = backView.frame
        backView.layoutSublayers(of: gradient)
        layer.addSublayer(gradient)
        backView.layer.insertSublayer(gradient, at: 0)
        backView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        addSubview(backView)
        backView.addSubview(stationName)
    }
}
