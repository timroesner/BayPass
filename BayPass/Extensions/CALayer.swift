//
//  CALayer.swift
//  BayPass
//
//  Created by Tim Roesner on 4/13/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import UIKit

extension CALayer {
    func applySketchShadow(color: UIColor, alpha: Float, x: CGFloat, y: CGFloat, blur: CGFloat, spread: CGFloat) {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
    
    func addOval(_ rect: CGRect, color: UIColor, width: CGFloat) {
        let ellipsePath = UIBezierPath(ovalIn: rect)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = ellipsePath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width
        addSublayer(shapeLayer)
    }
    
    func addLine(from: CGPoint, to: CGPoint, color: UIColor, width: CGFloat, dashed: Bool) {
        let line = CAShapeLayer()
        let linePath = UIBezierPath()
        linePath.move(to: from)
        linePath.addLine(to: to)
        line.path = linePath.cgPath
        line.strokeColor = color.cgColor
        if dashed {
            line.lineDashPattern = [12, 8]
            line.lineCap = .round
        }
        line.lineWidth = width
        line.lineJoin = CAShapeLayerLineJoin.round
        addSublayer(line)
    }
}

