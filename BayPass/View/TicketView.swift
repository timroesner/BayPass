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
        case 95:
            nameLbl.font = UIFont.systemFont(ofSize: 14, weight: .bold)
            size = 30
            offset = -4
        case 135:
            nameLbl.font = UIFont.systemFont(ofSize: 24, weight: .bold)
            size = 80
            offset = -4
        default:
            nameLbl.font = UIFont.systemFont(ofSize: 46, weight: .bold)
            size = 100
            offset = -8
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
