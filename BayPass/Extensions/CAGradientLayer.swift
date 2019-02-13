//
//  CAGradientLayer.swift
//  BayPass
//
//  Created by Tim Roesner on 10/31/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

import UIKit

extension CAGradientLayer {
    convenience init(topColor: UIColor, bottomColor: UIColor) {
        self.init()
        colors = [topColor.cgColor, bottomColor.cgColor]
        startPoint = CGPoint(x: 0, y: 0)
        endPoint = CGPoint(x: 1, y: 1)
    }

    convenience init(leftColor: UIColor, rightColor: UIColor) {
        self.init()
        colors = [leftColor.cgColor, rightColor.cgColor]
        startPoint = CGPoint(x: 0, y: 0.5)
        endPoint = CGPoint(x: 1, y: 0.5)
    }
}
