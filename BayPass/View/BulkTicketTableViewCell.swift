//
//  BulkTicketTableViewCell.swift
//  BayPass
//
//  Created by Tim Roesner on 5/1/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import SnapKit
import UIKit

class BulkTicketTableViewCell: UITableViewCell {
    var ticketView = TicketView(agency: Agency.VTA, icon: Agency.VTA.getIcon(), cornerRadius: 8)
    let nameLbl = UILabel()
    let priceLbl = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .none
    }

    func setup(with segment: RouteSegment?) {
        ticketView = TicketView(agency: segment?.line?.agency ?? .zero, icon: segment?.line?.agency.getIcon() ?? #imageLiteral(resourceName: "Bus"), cornerRadius: 8)
        addSubview(ticketView)
        ticketView.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(60)
            make.width.equalTo(95)
            make.centerY.equalToSuperview()
        }

        nameLbl.text = "Single Ride"
        addSubview(nameLbl)
        nameLbl.textColor = .black
        nameLbl.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        nameLbl.snp.makeConstraints { (make) -> Void in
            make.centerY.equalToSuperview()
            make.left.equalTo(ticketView.snp.right).offset(12)
        }

        priceLbl.text = String(format: "$%.2f", segment?.price ?? 0.0)
        priceLbl.textColor = .gray
        priceLbl.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        addSubview(priceLbl)
        priceLbl.snp.makeConstraints { (make) -> Void in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(20)
        }
    }

    override func prepareForReuse() {
        ticketView.removeFromSuperview()
    }

    required init?(coder _: NSCoder) {
        print("NSCoder not supported in BulkTicketCell")
        return nil
    }
}
