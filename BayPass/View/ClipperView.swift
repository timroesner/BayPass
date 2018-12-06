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
    let nameLbl = UILabel()
    var cashValueLbl = UILabel()
    let cardNumberLbl = UILabel()
    let imageView = UIImageView()
    
    public init(agency: String, icon: UIImage, cornerRadius: CGFloat, cardNumber: String) {
        super.init(frame: CGRect.zero)
        
        let agencyNoSpaces = agency.replacingOccurrences(of: " ", with: "")
        gradient1 = CAGradientLayer(leftColor: UIColor(named: "light\(agencyNoSpaces)") ?? UIColor(hex: 0x15224A),
                                   rightColor: UIColor(named: "dark\(agencyNoSpaces)") ?? UIColor(hex: 0x00648D))
        gradient1.cornerRadius = cornerRadius
        gradient1.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        layer.addSublayer(gradient1)
        
        gradient2 = CAGradientLayer(leftColor: UIColor(named: "light\(agencyNoSpaces)") ?? UIColor(hex: 0x162D58),
                                    rightColor: UIColor(named: "dark\(agencyNoSpaces)") ?? UIColor(hex: 0x005580))
        gradient2.cornerRadius = cornerRadius
        gradient2.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        layer.addSublayer(gradient2)
        
        nameLbl.text = agency
        nameLbl.textColor = .white
        nameLbl.numberOfLines = 0
        addSubview(nameLbl)
        
        cashValueLbl.text = "$12.45"
        cashValueLbl.textColor = .white
        cashValueLbl.numberOfLines = 1
        addSubview(cashValueLbl)
        
        cardNumberLbl.text = cardNumber
        cardNumberLbl.textColor = .white
        cardNumberLbl.numberOfLines = 0
        addSubview(cardNumberLbl)
        
        imageView.tintColor = .white
        imageView.image = icon
        addSubview(imageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradient1.frame = CGRect(x: 0.0, y: 0.0, width: 210, height: 200)
        gradient2.frame = CGRect(x: 210, y: 0.0, width: 140, height: 200)
        
        //nameLbl.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        cashValueLbl.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        cardNumberLbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        imageView.frame = CGRect(x: 44, y: 30, width: 120, height: 146)
        /*imageView.snp.makeConstraints({ (make) -> Void in
            make.bottom.equalToSuperview().offset(-30)
            make.left.equalToSuperview().offset(80)
        })*/
        
        /*nameLbl.snp.makeConstraints({ (make) -> Void in
            make.bottom.equalToSuperview().offset(-30)
            make.left.equalToSuperview().offset(44)
        })*/
        
        cashValueLbl.snp.makeConstraints({ (make) -> Void in
            make.top.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-18)
        })
        
        cardNumberLbl.snp.makeConstraints({ (make) -> Void in
            make.bottom.equalToSuperview().offset(-16)
            make.right.equalToSuperview().offset(-18)
        })
    }
    
    func setBalanceLbl(cashValue: String) {
        cashValueLbl.text = cashValue
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("NSCoder not supported in TicketView")
    }

}
