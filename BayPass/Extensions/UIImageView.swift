//
//  UIView.swift
//  BayPass
//
//  Created by Zhe Li on 3/6/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import UIKit

extension UIImageView {
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")

        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards

        layer.add(animation, forKey: nil)
    }
}
