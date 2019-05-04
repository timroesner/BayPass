//
//  UIView.swift
//  BayPass
//
//  Created by Ayesha Khan on 5/4/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import UIKit

extension UIView {
    func setGradientBackground(setColor: UIColor) {
        let leftColor = setColor.lighter(by: 30)
        var gradientLayer = CAGradientLayer()
        gradientLayer = CAGradientLayer(leftColor: leftColor ?? #colorLiteral(red: 0.1754914722, green: 0.8503269947, blue: 1, alpha: 1), rightColor: setColor)
        gradientLayer.name = "layerName"
        gradientLayer.frame = layer.bounds
        layer.addSublayer(gradientLayer)
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
