//
//  UIColor.swift
//  BayPass
//
//  Created by Tim Roesner on 10/25/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(hex: Int) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF
        )
    }

    var lightGrey: UIColor {
        return UIColor(white: 155.0 / 255.0, alpha: 1.0)
    }

    var clipperBlue: UIColor {
        return UIColor(hex: 0x0C3F6A)
    }

    func encode() -> String? {
        let components = cgColor.components ?? []
        guard components.count == 4 else {
            return nil
        }
        return "\(components[0])#\(components[1])#\(components[2])#\(components[3])"
    }

    // Takes a string of the following format "red#green#blue#alpha"
    // All components must be between 0.0 and 1.0
    convenience init(string: String) {
        let colorArrayString = string.split(separator: "#")
        var colorArray = [CGFloat]()

        for item in colorArrayString {
            if let n = NumberFormatter().number(from: String(item)) {
                colorArray.append(CGFloat(truncating: n))
            }
        }
        assert(colorArray.count == 4, "Invalid string")
        self.init(red: colorArray[0], green: colorArray[1], blue: colorArray[2], alpha: colorArray[3])
    }
}
