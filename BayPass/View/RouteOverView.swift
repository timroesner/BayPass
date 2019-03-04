//
//  RouteOverview.swift
//  BayPass
//
//  Created by Tim Roesner on 3/3/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import UIKit
import SnapKit

class RouteOverView: UIView {
    
    private let durationLabel = UILabel()
    private let timeLabel = UILabel()
    private let priceLabel = UILabel()
    private let segmentView = UIView()
    
    init(with route: Route) {
        super.init(frame: CGRect.zero)
        
        layer.backgroundColor = UIColor.white.cgColor
        layer.cornerRadius = 14
        
        addSubview(durationLabel)
        durationLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        durationLabel.text = route.departureTime.duration(to: route.arrivalTime)
        durationLabel.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(16)
        }
        
        addSubview(timeLabel)
        timeLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        timeLabel.textColor = UIColor().lightGrey
        timeLabel.text = "\(route.departureTime.timeShort()) - \(route.arrivalTime.timeShort())"
        timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(durationLabel.snp.bottom).offset(2)
            make.left.equalTo(durationLabel)
        }
        
        addSubview(priceLabel)
        priceLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        priceLabel.text = route.getPrice()
        priceLabel.textAlignment = .right
        priceLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(16)
            make.centerY.equalTo(durationLabel)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoder has not been implemented for RouteOverView")
    }
}
