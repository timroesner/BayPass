//
//  TicketView.swift
//  BayPass
//
//  Created by Tim Roesner on 10/31/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

import SnapKit
import UIKit

class TicketView: UIView {
    var gradient = CAGradientLayer()
    let nameLbl = UILabel()
    let imageView = UIImageView()

    public init(agency: String, icon: UIImage, cornerRadius: CGFloat) {
        super.init(frame: CGRect.zero)

        let agencyNoSpaces = agency.replacingOccurrences(of: " ", with: "")
        gradient = CAGradientLayer(topColor: UIColor(named: "light\(agencyNoSpaces)") ?? UIColor(hex: 0x000), bottomColor: UIColor(named: "dark\(agencyNoSpaces)") ?? UIColor(hex: 0x000))
        gradient.cornerRadius = cornerRadius
        layer.addSublayer(gradient)

        imageView.tintColor = .white
        imageView.image = icon
        addSubview(imageView)

        nameLbl.text = agency
        nameLbl.textColor = .white
        nameLbl.numberOfLines = 0
        addSubview(nameLbl)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = bounds

        var size = 0
        var offset = 0

        switch frame.width {
        // 85 x 125
        case 50 ... 85:
            nameLbl.font = UIFont.systemFont(ofSize: 14, weight: .bold)
            size = 50
            offset = -4
        // 95 x 60
        case 86 ... 95:
            nameLbl.font = UIFont.systemFont(ofSize: 15, weight: .bold)
            size = 30
            offset = -4
        // 135 x 200
        case 96 ... 135:
            nameLbl.font = UIFont.systemFont(ofSize: 24, weight: .bold)
            size = 80
            offset = -6
        // 160 x 85
        case 136 ... 160:
            nameLbl.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            size = 45
            offset = -6
        // 250 x 140
        case 161 ... 250:
            nameLbl.font = UIFont.systemFont(ofSize: 30, weight: .bold)
            size = 70
            offset = -8
        // 335 x 190
        case 251 ... 415:
            nameLbl.font = UIFont.systemFont(ofSize: 46, weight: .bold)
            size = 100
            offset = -8
        default:
            print("Unexpected size of TicketView")
            return
        }

        imageView.snp.makeConstraints({ (make) -> Void in
            make.width.height.equalTo(size)
            make.bottom.right.equalToSuperview().offset(offset)
        })

        nameLbl.snp.makeConstraints({ (make) -> Void in
            make.leading.equalToSuperview().offset(-2 * offset)
            make.top.equalToSuperview().offset(-1.5 * Double(offset))
            make.trailing.equalToSuperview().offset(2 * offset)
        })
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("NSCoder not supported in TicketView")
    }
}
