//
//  ticketCarouselViewCell.swift
//  BayPass
//
//  Created by Zhe Li on 4/13/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import Foundation
import SnapKit

class ticketCarouselViewCell: UICollectionViewCell {
    var ticketView = TicketView(agency: "ACE", icon: UIImage(named: "CalTrain")!, cornerRadius: 12)

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    func setup(with newTicketView: TicketView) {
        ticketView = newTicketView
        addSubview(ticketView)
        ticketView.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(135)
            make.height.equalTo(200)
        }
        ticketView.layoutIfNeeded()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
