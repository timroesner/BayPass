//
//  RouteDetailsViewController.swift
//  BayPass
//
//  Created by Tim Roesner on 4/13/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import UIKit

class RouteDetailsViewController: UIViewController {
    
    let scrollView = UIScrollView()
    var route: Route?
    var routeOverView: RouteOverView?
    private var buyButton = UIButton()
    private let dashedView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.layer.backgroundColor = UIColor(hex: 0xF8F8F8).cgColor
        view.layer.cornerRadius = 21
        setupViews()
    }
    
    func setupViews() {
        guard let route = route else {
            self.displayAlert(title: "Error", msg: "No route to display", dismissAfter: false)
            return
        }
        
        let routeHasMultipleTransit = route.segments.filter{ $0.travelMode == .transit }.count > 1
        
        if routeHasMultipleTransit {
            buyButton = BayPassButton(title: "Buy Tickets", color: #colorLiteral(red: 0.6504354477, green: 0.4037398994, blue: 0.844121635, alpha: 1))
        } else {
            let lineColor = route.segments.filter{ $0.travelMode == .transit }.first?.line?.color ?? .blue
            buyButton = BayPassButton(title: "Buy Ticket", color: lineColor)
        }
        
        view.addSubview(routeOverView!)
        routeOverView?.snp.makeConstraints({ (make) in
            make.top.equalToSuperview().offset(-60)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(122)
        })
        
        buyButton.addTarget(self, action: #selector(buyTapped), for: .touchUpInside)
        view.addSubview(buyButton)
        buyButton.snp.makeConstraints { (make) in
            make.top.equalTo(routeOverView!.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(buyButton.snp.bottom).offset(16)
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        let contentView = UIView()
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(scrollView)
            make.left.right.equalTo(view)
            make.width.equalTo(scrollView)
        }
        
        // MARK: Setting up views and labels
        let leaveLabel = sixteenSemiboldLabel(text: "Leave")
        contentView.addSubview(leaveLabel)
        leaveLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(47)
        }
        
        let leaveTimeLabel = timeLabel(date: route.departureTime)
        contentView.addSubview(leaveTimeLabel)
        leaveTimeLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(20)
            make.centerY.equalTo(leaveLabel)
        }
        
        var segmentViews = [UIView]()
        for segment in route.segments {
            if segment.travelMode != .transit {
                let nonTransitView = segmentView(with: segment)
                contentView.addSubview(nonTransitView)
                nonTransitView.snp.makeConstraints { (make) in
                    make.left.equalTo(leaveLabel)
                    make.top.equalTo(segmentViews.last?.snp.bottom ?? leaveLabel.snp.bottom).offset(20)
                }
                segmentViews.append(nonTransitView)
            } else {
                let transitView = LineDetailView(with: segment)
                contentView.addSubview(transitView)
                transitView.snp.makeConstraints { (make) in
                    make.left.right.equalToSuperview().inset(20)
                    make.top.equalTo(segmentViews.last?.snp.bottom ?? leaveLabel.snp.bottom).offset(20)
                }
                segmentViews.append(transitView)
            }
        }
        
        let arriveLabel = sixteenSemiboldLabel(text: "Arrive")
        contentView.addSubview(arriveLabel)
        arriveLabel.snp.makeConstraints { (make) in
            make.left.equalTo(leaveLabel)
            make.top.equalTo(segmentViews.last?.snp.bottom ?? leaveLabel.snp.bottom).offset(20)
            make.bottom.equalToSuperview().inset(8)
        }
        
        let arriveTimeLabel = timeLabel(date: route.arrivalTime)
        contentView.addSubview(arriveTimeLabel)
        arriveTimeLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(20)
            make.centerY.equalTo(arriveLabel)
        }
        
        contentView.addSubview(dashedView)
        contentView.sendSubviewToBack(dashedView)
        dashedView.snp.makeConstraints { (make) in
            make.top.equalTo(leaveLabel)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(25)
            make.bottom.equalTo(arriveLabel)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupDashedView()
        
        if scrollView.contentSize.height < scrollView.frame.height {
            scrollView.isUserInteractionEnabled = false
        }
    }
    
    func setupDashedView() {
        let width = dashedView.frame.width-8
        dashedView.layer.addOval(CGRect(x: 4, y: 4, width: width, height: width), color: .gray, width: 3.0)
        dashedView.layer.addLine(from: CGPoint(x: dashedView.frame.width/2, y: width+4), to: CGPoint(x: dashedView.frame.width/2, y: dashedView.frame.height-width), color: .gray, width: 3.0, dashed: true)
        dashedView.layer.addOval(CGRect(x: 4, y: dashedView.frame.height-width, width: width, height: width), color: .gray, width: 3.0)
    }
    
    func sixteenSemiboldLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        return label
    }
    
    func timeLabel(date: Date) -> UILabel {
        let label = UILabel()
        label.textColor = .gray
        label.text = date.timeShort()
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textAlignment = .right
        return label
    }
    
    func segmentView(with segment: RouteSegment) -> UIView {
        let view = UIView()
        
        let iconView = UIImageView()
        iconView.tintColor = .black
        view.addSubview(iconView)
        iconView.snp.makeConstraints { (make) in
            make.top.bottom.left.equalToSuperview()
            make.width.height.equalTo(25)
        }
        
        let titleLabel = UILabel()
        let subtitleLabel = UILabel()
        
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        view.addSubview(titleLabel)
        
        switch segment.travelMode {
        case .walking:
            iconView.image = #imageLiteral(resourceName: "Walking")
            titleLabel.text = "Walk \(segment.distanceInMeters)m"
        case .scooter:
            iconView.image = #imageLiteral(resourceName: "Scooter")
            let duration = ScooterCompany.shared.getDurationInMinutes(fromMeters: Double(segment.distanceInMeters))
            titleLabel.text = "Scooter for \(duration) min"
            subtitleLabel.text = String(format: "Estimated charge: $%.2f", ScooterCompany.shared.calculatePrice(fromMinutes: duration))
        case .bike:
            iconView.image = #imageLiteral(resourceName: "Bike")
            let duration = BikeDock.shared.getDurationInMinutes(fromMeters: Double(segment.distanceInMeters), eBike: false)
            titleLabel.text = "Bike for \(duration) min"
            subtitleLabel.text = String(format: "Estimated charge: $%.2f", BikeDock.shared.calculatePrice(fromMinutes: Double(duration)))
        default:
            break
        }
        
        if segment.travelMode == .walking {
            titleLabel.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.left.equalTo(iconView.snp.right).offset(8)
            }
        } else if segment.travelMode != .transit {
            titleLabel.snp.makeConstraints { (make) in
                make.top.equalToSuperview()
                make.left.equalTo(iconView.snp.right).offset(8)
            }
            subtitleLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
            subtitleLabel.textColor = .gray
            view.addSubview(subtitleLabel)
            subtitleLabel.snp.makeConstraints { (make) in
                make.top.equalTo(titleLabel.snp.bottom).offset(2)
                make.left.equalTo(titleLabel)
            }
        }
        return view
    }
    
    @objc func buyTapped() {
        print("Let's buy")
    }

}
