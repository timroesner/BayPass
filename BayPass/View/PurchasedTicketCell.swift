//
//  PurchesedTicketCell.swift
//  BayPass
//
//  Created by Zhe Li on 2/19/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//
import SnapKit
import UIKit

class PurchasedTicketCell: UITableViewCell {
    var ticketView = TicketView(agency: Agency.VTA, icon: Agency.VTA.getIcon(), cornerRadius: 8)
    let nameLbl = UILabel()
    let durationLbl = UILabel()
    let background = UILabel()
    let showLbl = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    func setup(with ticket: Ticket) {
        ticketView = TicketView(agency: ticket.validOnAgency, icon: ticket.validOnAgency.getIcon(), cornerRadius: 8)
        addSubview(ticketView)
        ticketView.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(60)
            make.width.equalTo(95)
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
        }

        if let dur = ticket.duration {
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone(identifier: "America/Los_Angeles")
            dateFormatter.locale = Locale(identifier: "en_US")
            dateFormatter.setLocalizedDateFormatFromTemplate("MMMMd")
            let stringOutput = dateFormatter.string(from: dur.end)
            durationLbl.text = "Valid until " + stringOutput
            addSubview(durationLbl)
            durationLbl.textColor = .gray
            durationLbl.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
            durationLbl.snp.makeConstraints { (make) -> Void in
                make.top.equalToSuperview().offset(30)
                make.left.equalToSuperview().offset(125)
            }
        }

        nameLbl.text = ticket.name
        addSubview(nameLbl)
        nameLbl.textColor = .black
        nameLbl.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        nameLbl.snp.makeConstraints { (make) -> Void in
            if ticket.duration == nil {
                make.centerY.equalToSuperview().priorityLow()
            } else {
                make.top.equalTo(durationLbl.snp.bottom).offset(1)
            }
            make.left.equalToSuperview().offset(125)
        }

        background.layer.backgroundColor = UIColor(red: 0.91, green: 0.90, blue: 0.90, alpha: 1.00).cgColor
        background.layer.cornerRadius = 11
        addSubview(background)
        background.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(9)
            make.width.equalTo(60)
            make.height.equalTo(22)
        }

        showLbl.textColor = UIColor(red: 0.16, green: 0.47, blue: 0.96, alpha: 1)
        showLbl.text = "Show"
        showLbl.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        addSubview(showLbl)
        showLbl.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(background)
        }
    }

    override func prepareForReuse() {
        ticketView.removeFromSuperview()
        durationLbl.text = ""
    }

    required init?(coder _: NSCoder) {
        print("NSCoder not supported in PurchasedTicketCell")
        return nil
    }
}
