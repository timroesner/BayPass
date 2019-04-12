//
//  LineDetailView.swift
//  BayPass
//
//  Created by Tim Roesner on 4/12/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import UIKit

class LineDetailView: UIView {
    private let nameLabel = UILabel()
    private let iconView = UIImageView()
    private let startLabel = UILabel()
    private let startTimeLabel = UILabel()
    private let destinationLabel = UILabel()
    private let endLabel = UILabel()
    private let endTimeLabel = UILabel()
    private let dotView = UIView()
    
    init(with routeSegment: RouteSegment) {
        super.init(frame: CGRect.zero)
        
        setupView(with: routeSegment)
    }
    
    func setupView(with routeSegment: RouteSegment) {
        // TODO: Line icon
        iconView.tintColor = .gray
        iconView.image = #imageLiteral(resourceName: "Bus")
        addSubview(iconView)
        iconView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(12)
            make.width.height.equalTo(30)
        }
        
        // TODO: Adjust to new Line model
        nameLabel.text = routeSegment.line?.name
        nameLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        nameLabel.textColor = .blue
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconView.snp.right).offset(3)
            make.centerY.equalTo(iconView)
        }
        
        // TODO: Adjust to new model
        startLabel.text = routeSegment.waypoints.first?.name
        startLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        startLabel.textColor = .black
        addSubview(startLabel)
        startLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(2)
            make.left.equalTo(nameLabel)
        }
        
        startTimeLabel.text = routeSegment.departureTime?.timeShort()
        startTimeLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        startTimeLabel.textColor = .gray
        startTimeLabel.textAlignment = .right
        addSubview(startTimeLabel)
        startTimeLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(startLabel)
            make.right.equalToSuperview().inset(15)
        }
        
        destinationLabel.text = routeSegment.line?.destination
        destinationLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        destinationLabel.textColor = .gray
        addSubview(destinationLabel)
        destinationLabel.snp.makeConstraints { (make) in
            make.top.equalTo(startLabel.snp.bottom).offset(2)
            make.left.equalTo(startLabel)
        }
        
        // TODO: Adjust to new model
        endLabel.text = routeSegment.waypoints.last?.name
        
        // TODO: Add fucntion to setup view with line color
        dotView.backgroundColor = .blue
        addSubview(dotView)
        dotView.snp.makeConstraints { (make) in
            make.top.equalTo(startLabel)
            make.width.equalTo(iconView)
            make.centerX.equalTo(iconView)
            // Bottom equal to stopLabel
        }
        setupDotView(with: .blue)
    }
    
    func setupDotView(with color: UIColor) {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        print("NSCoder not implemented for LineDetailView")
        return nil
    }
}
