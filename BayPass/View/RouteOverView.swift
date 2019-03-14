//
//  RouteOverview.swift
//  BayPass
//
//  Created by Tim Roesner on 3/3/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import SnapKit
import UIKit

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
        durationLabel.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(16)
        }

        addSubview(timeLabel)
        timeLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        timeLabel.textColor = UIColor().lightGrey
        timeLabel.text = "\(route.departureTime.timeShort()) - \(route.arrivalTime.timeShort())"
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(durationLabel.snp.bottom).offset(2)
            make.left.equalTo(durationLabel)
        }

        addSubview(priceLabel)
        priceLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        priceLabel.text = route.getPrice()
        priceLabel.textAlignment = .right
        priceLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.centerY.equalTo(durationLabel)
        }
        let lineView = setupLineView(with: route)
        addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.left.equalTo(timeLabel)
            make.top.equalTo(timeLabel.snp.bottom).offset(15)
            make.height.equalTo(40)
            make.right.greaterThanOrEqualToSuperview().inset(16)
        }
    }

    private func setupLineView(with route: Route) -> UIView {
        let lineView = UIView()
        let totalDuration = route.arrivalTime.timeIntervalSince(route.departureTime)

        let multiplier = totalDuration / 3600
        let maxWidth = Double(UIScreen.main.bounds.width - 74)
        let viewWidth = min((maxWidth / 1.5) * multiplier, maxWidth)

        var labels = [UILabel]()

        for segment in route.segments {
            let lineLabel = UILabel()
            let lineMultiplier = Double(segment.durationInMinutes) / (totalDuration / 60)
            let lineWidth = viewWidth * lineMultiplier - 2
            lineLabel.layer.cornerRadius = 4

            if segment.travelMode == .transit {
                // TODO: Replace with actual line color
                lineLabel.layer.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            } else {
                lineLabel.layer.backgroundColor = UIColor(red: 216, green: 216, blue: 216).cgColor
            }

            if lineWidth > 33 {
                if lineWidth > 74, segment.travelMode == .transit {
                    let canvas = UIView()
                    let icon = UIImageView()
                    icon.tintColor = .white
                    // TODO: Replace with actual line icon
                    icon.image = #imageLiteral(resourceName: "Bus")
                    canvas.addSubview(icon)
                    icon.snp.makeConstraints { make in
                        make.left.equalToSuperview()
                        make.centerY.equalToSuperview()
                        make.width.height.equalTo(28)
                    }
                    let label = UILabel()
                    label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
                    label.textColor = .white
                    label.text = segment.line?.name
                    canvas.addSubview(label)
                    label.snp.makeConstraints { make in
                        make.left.equalTo(icon.snp.right).offset(2)
                        make.right.equalToSuperview()
                        make.centerY.equalToSuperview()
                        make.height.equalTo(20)
                    }
                    lineLabel.addSubview(canvas)
                    canvas.snp.makeConstraints { make in
                        make.center.equalToSuperview()
                    }
                } else {
                    let icon = UIImageView()
                    icon.tintColor = .black
                    switch segment.travelMode {
                    case .walking:
                        icon.image = #imageLiteral(resourceName: "Walking")
                    case .scooter:
                        icon.image = #imageLiteral(resourceName: "Scooter")
                    case .bike:
                        icon.image = #imageLiteral(resourceName: "Bike")
                    case .transit:
                        icon.tintColor = .white
                        // TODO: replace with line icon
                        icon.image = #imageLiteral(resourceName: "Bus")
                    }
                    lineLabel.addSubview(icon)
                    icon.snp.makeConstraints { make in
                        make.center.equalToSuperview()
                        make.width.height.equalTo(28)
                    }
                }
            }
            if lineWidth > 4 {
                lineView.addSubview(lineLabel)
                lineLabel.snp.makeConstraints { make in
                    make.top.bottom.equalToSuperview()
                    make.width.equalTo(lineWidth)
                    if let previous = labels.last {
                        make.left.equalTo(previous.snp.right).offset(2)
                    } else {
                        make.left.equalToSuperview()
                    }
                }
                labels.append(lineLabel)
            }
        }
        return lineView
    }

    required init?(coder _: NSCoder) {
        print("NSCoder not supported in RouteOverView")
        return nil
    }
}
