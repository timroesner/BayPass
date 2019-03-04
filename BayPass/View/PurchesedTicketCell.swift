//
//  PurchesedTicketCell.swift
//  BayPass
//
//  Created by Zhe Li on 2/19/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import SnapKit
import UIKit

class PurchesedTicketCell: UITableViewCell {
    var ticketView = TicketView(agency: "ACE", icon: UIImage(named: "CalTrain")!, cornerRadius: 8)
    // var ticketView: TicketView?
    let nameLbl = UILabel()
    let durationLbl = UILabel()
    let showLbl = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // setup()
        addSubview(ticketView)
        ticketView.snp.makeConstraints({ (make) -> Void in
            make.height.equalTo(60)
            make.width.equalTo(95)
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
        })

        addSubview(durationLbl)
        durationLbl.textColor = .gray
        // durationLbl.text = "Valid until "
        durationLbl.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        durationLbl.snp.makeConstraints({ (make) -> Void in
            make.top.equalToSuperview().offset(30)
            make.left.equalTo(ticketView.snp.right).offset(14)
        })

        addSubview(nameLbl)
        nameLbl.textColor = .black
        nameLbl.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        nameLbl.snp.makeConstraints({ (make) -> Void in
            make.top.equalTo(durationLbl.snp.bottom).offset(0)
            make.left.equalTo(ticketView.snp.right).offset(14)
        })

        addSubview(showLbl)
        showLbl.backgroundColor = UIColor(red: 0.91, green: 0.90, blue: 0.90, alpha: 1.00)
        showLbl.textColor = UIColor(red: 0.16, green: 0.47, blue: 0.96, alpha: 1)
        showLbl.text = "   Show   "
        showLbl.layer.masksToBounds = true
        showLbl.layer.cornerRadius = 8
        showLbl.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        showLbl.snp.makeConstraints({ (make) -> Void in
            make.top.equalToSuperview().offset(39)
            make.right.equalToSuperview().offset(-12)
        })
    }

    func setup(with ticket: Ticket) {
        nameLbl.text = ticket.name
        ticketView = TicketView(agency: ticket.validOnAgency.name, icon: ticket.validOnAgency.icon, cornerRadius: 8)

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        let stringOutput = dateFormatter.string(from: ticket.duration!.end)
        durationLbl.text = "Valid until " + stringOutput
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
