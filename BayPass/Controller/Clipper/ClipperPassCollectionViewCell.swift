//
//  ClipperPassCollectionViewCell.swift
//  BayPass
//
//  Created by Tim Roesner on 4/1/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//
import UIKit

class ClipperPassCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
    }
    
    override func prepareForReuse() {
        let _ = contentView.subviews.map{$0.removeFromSuperview()}
    }

    func setup(with pass: Pass) {
        let ticketView = TicketView(agency: pass.validOnAgency, icon: pass.validOnAgency.getIcon(), cornerRadius: 8)
        contentView.addSubview(ticketView)
        ticketView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.right.top.bottom.equalToSuperview()
        }
    }

    func setupAdd() {
        contentView.layer.backgroundColor = UIColor(hex: 0x9B9B9B).cgColor
        contentView.layer.cornerRadius = 8

        let title = UILabel()
        title.text = "Add"
        title.textColor = .white
        title.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        contentView.addSubview(title)
        title.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(8)
            make.top.equalToSuperview().offset(5)
        }

        let iconView = UIImageView()
        iconView.tintColor = .white
        iconView.image = #imageLiteral(resourceName: "Add")
        contentView.addSubview(iconView)
        iconView.snp.makeConstraints { make in
            make.right.bottom.equalToSuperview()
            make.width.height.equalTo(50)
        }
    }

    required init?(coder _: NSCoder) {
        print("NSCoder not supported in ClipperPassCollectionViewCell")
        return nil
    }
}
