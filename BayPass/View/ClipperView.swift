//
//  ClipperView.swift
//  BayPass
//
//  Created by Zhe Li on 12/3/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

import SnapKit
import UIKit

class ClipperView: UIView {
    var gradient1 = CAGradientLayer()
    var gradient2 = CAGradientLayer()
    var cashValueLbl = UILabel()
    let cardNumberLbl = UILabel()
    let imageView = UIImageView()

    public init(cardNumber: String, cashValue: Double) {
        super.init(frame: CGRect.zero)

        let agencyNoSpaces = "Clipper".replacingOccurrences(of: " ", with: "")
        gradient1 = CAGradientLayer(leftColor: UIColor(named: "light\(agencyNoSpaces)") ?? UIColor(hex: 0x15224A),
                                    rightColor: UIColor(named: "dark\(agencyNoSpaces)") ?? UIColor(hex: 0x00648D))
        gradient1.cornerRadius = 12
        gradient1.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        layer.addSublayer(gradient1)

        gradient2 = CAGradientLayer(leftColor: UIColor(named: "light\(agencyNoSpaces)") ?? UIColor(hex: 0x162D58),
                                    rightColor: UIColor(named: "dark\(agencyNoSpaces)") ?? UIColor(hex: 0x005580))
        gradient2.cornerRadius = 12
        gradient2.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        layer.addSublayer(gradient2)

        cashValueLbl.text = "$\(cashValue)"
        cashValueLbl.textColor = .white
        cashValueLbl.numberOfLines = 1
        addSubview(cashValueLbl)

        cardNumberLbl.text = cardNumber
        cardNumberLbl.textColor = .white
        cardNumberLbl.numberOfLines = 0
        addSubview(cardNumberLbl)

        imageView.tintColor = .white
        imageView.image = #imageLiteral(resourceName: "ClipperLogoVertical")
        addSubview(imageView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        gradient1.frame = CGRect(x: 0.0, y: 0.0, width: frame.width * 0.6, height: frame.height)
        gradient2.frame = CGRect(x: frame.width * 0.6, y: 0.0, width: frame.width * 0.4, height: frame.height)

        imageView.frame = CGRect(x: frame.width * 0.13, y: frame.height * 0.135, width: frame.width * 0.34, height: frame.height * 0.73)

        cashValueLbl.snp.makeConstraints({ (make) -> Void in
            make.top.equalToSuperview().offset(frame.height * 0.08)
            make.right.equalToSuperview().offset(-frame.width * 0.05)
        })

        cardNumberLbl.snp.makeConstraints({ (make) -> Void in
            make.bottom.equalToSuperview().offset(-frame.height * 0.08)
            make.right.equalToSuperview().offset(-frame.width * 0.05)
        })

        switch frame.width {
        case 25 ... 135:
            cashValueLbl.font = UIFont.systemFont(ofSize: 9, weight: .bold)
            cardNumberLbl.font = UIFont.systemFont(ofSize: 6, weight: .regular)
        case 136 ... 250:
            cashValueLbl.font = UIFont.systemFont(ofSize: 14, weight: .bold)
            cardNumberLbl.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        case 251 ... 375:
            cashValueLbl.font = UIFont.systemFont(ofSize: 24, weight: .bold)
            cardNumberLbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        default:
            print("Unexpected size of TicketView")
            return
        }
    }

    func setBalanceLbl(cashValue: String) {
        cashValueLbl.text = cashValue
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("NSCoder not supported in TicketView")
    }
}
