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

    public init(cardNumber: Int, cashValue: Double) {
        super.init(frame: CGRect.zero)

        gradient1 = CAGradientLayer(leftColor: UIColor(hex: 0x15224A), rightColor: UIColor(hex: 0x00648D))
        gradient1.cornerRadius = 12
        gradient1.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        layer.addSublayer(gradient1)

        gradient2 = CAGradientLayer(leftColor: UIColor(hex: 0x162D58), rightColor: UIColor(hex: 0x005580))
        gradient2.cornerRadius = 12
        gradient2.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        layer.addSublayer(gradient2)

        setBalanceLbl(cashValue: cashValue)
        cashValueLbl.textColor = .white
        cashValueLbl.numberOfLines = 1
        addSubview(cashValueLbl)

        cardNumberLbl.text = "•••• " + String(cardNumber).suffix(4)
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

        imageView.snp.makeConstraints({ (make) -> Void in
            make.top.bottom.equalToSuperview().inset(30)
            make.centerX.equalTo(gradient1.frame.width / 2)
            make.width.equalTo(imageView.snp.height).multipliedBy(0.82)
        })

        cashValueLbl.snp.makeConstraints({ (make) -> Void in
            make.top.equalToSuperview().offset(frame.height * 0.08)
            make.right.equalToSuperview().offset(-frame.width * 0.05)
        })

        cardNumberLbl.snp.makeConstraints({ (make) -> Void in
            make.bottom.equalToSuperview().offset(-frame.height * 0.08)
            make.right.equalToSuperview().offset(-frame.width * 0.05)
        })

        switch frame.width {
        // 135 x 77
        case 25 ... 135:
            cashValueLbl.font = UIFont.systemFont(ofSize: 9, weight: .bold)
            cardNumberLbl.font = UIFont.systemFont(ofSize: 6, weight: .regular)
        // 250 x 142
        case 136 ... 250:
            cashValueLbl.font = UIFont.systemFont(ofSize: 14, weight: .bold)
            cardNumberLbl.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        // 375 x 214
        case 251 ... 415:
            cashValueLbl.font = UIFont.systemFont(ofSize: 24, weight: .bold)
            cardNumberLbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        default:
            print("Unexpected size of ClipperView")
            return
        }
    }

    func setBalanceLbl(cashValue: Double) {
        cashValueLbl.text = String(format: "$%.2f", cashValue)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("NSCoder not supported in TicketView")
    }
}
