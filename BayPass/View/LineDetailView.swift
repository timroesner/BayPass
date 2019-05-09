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
    private let color: UIColor

    init(with routeSegment: RouteSegment) {
        color = routeSegment.line?.color ?? .blue
        super.init(frame: CGRect.zero)
        backgroundColor = .white
        layer.backgroundColor = UIColor.white.cgColor
        layer.cornerRadius = 20

        setupView(with: routeSegment)
    }

    func setupView(with routeSegment: RouteSegment) {
        iconView.tintColor = .gray
        iconView.image = routeSegment.line?.getIcon()
        addSubview(iconView)
        iconView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(12)
            make.width.height.equalTo(30)
        }

        nameLabel.text = routeSegment.line?.name
        nameLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        nameLabel.textColor = routeSegment.line?.color
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(iconView.snp.right).offset(3)
            make.centerY.equalTo(iconView)
            make.right.equalToSuperview().inset(15)
        }

        startLabel.text = routeSegment.waypoints.first
        startLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        startLabel.textColor = .black
        addSubview(startLabel)
        startLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(2)
            make.left.equalTo(nameLabel)
        }

        startTimeLabel.text = routeSegment.departureTime?.timeShort()
        startTimeLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        startTimeLabel.textColor = .gray
        startTimeLabel.textAlignment = .right
        addSubview(startTimeLabel)
        startTimeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(startLabel)
            make.right.equalToSuperview().inset(15)
            make.left.greaterThanOrEqualTo(startLabel.snp.right).offset(4)
            make.width.equalTo(60)
        }

        destinationLabel.text = routeSegment.line?.destination
        destinationLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        destinationLabel.textColor = .gray
        addSubview(destinationLabel)
        destinationLabel.snp.makeConstraints { make in
            make.top.equalTo(startLabel.snp.bottom).offset(2)
            make.left.equalTo(startLabel)
            make.right.lessThanOrEqualToSuperview().offset(-15)
        }

        endLabel.text = routeSegment.waypoints.last
        endLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        endLabel.textColor = .black
        addSubview(endLabel)
        endLabel.snp.makeConstraints { make in
            make.top.equalTo(destinationLabel.snp.bottom).offset(30)
            make.left.equalTo(startLabel)
            make.bottom.equalToSuperview().inset(8)
        }

        endTimeLabel.text = routeSegment.arrivalTime?.timeShort()
        endTimeLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        endTimeLabel.textColor = .gray
        endTimeLabel.textAlignment = .right
        addSubview(endTimeLabel)
        endTimeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(endLabel)
            make.right.equalToSuperview().inset(15)
            make.left.greaterThanOrEqualTo(endLabel.snp.right).offset(4)
            make.width.equalTo(60)
        }

        addSubview(dotView)
        dotView.snp.makeConstraints { make in
            make.top.equalTo(startLabel)
            make.width.equalTo(iconView)
            make.centerX.equalTo(iconView)
            make.bottom.equalTo(endLabel)
        }

        // Shadow
        layer.applySketchShadow(color: .black, alpha: 0.18, x: -3, y: 6, blur: 25, spread: -10)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupDotView(with: color)
    }

    func setupDotView(with color: UIColor) {
        let width = dotView.bounds.width - 16
        dotView.layer.addOval(CGRect(x: 8, y: 0, width: width, height: width), color: color, width: 2.5)
        dotView.layer.addLine(from: CGPoint(x: dotView.frame.width / 2, y: width), to: CGPoint(x: dotView.frame.width / 2, y: dotView.frame.height - width), color: color, width: 2.5, dashed: false)
        dotView.layer.addOval(CGRect(x: 8, y: dotView.frame.height - width, width: width, height: width), color: color, width: 2.5)
    }

    required init?(coder _: NSCoder) {
        print("NSCoder not implemented for LineDetailView")
        return nil
    }
}
