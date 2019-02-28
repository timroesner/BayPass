//
//  DestinationSearchResultTableViewCell.swift
//  BayPass
//
//  Created by Tim Roesner on 2/27/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import MapKit
import SnapKit
import UIKit

class DestinationSearchResultTableViewCell: UITableViewCell {
    private(set) var iconView = UIImageView()
    private(set) var titleLabel = UILabel()
    private(set) var subtitleLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        iconView.tintColor = UIColor(hex: 0x9B9B9B)
        iconView.image = #imageLiteral(resourceName: "MapMarker")
        contentView.addSubview(iconView)
        iconView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.top.equalToSuperview().inset(9)
            make.bottom.equalToSuperview().inset(9)
            make.width.equalTo(iconView.snp.height)
        }

        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(iconView.snp.right).offset(14)
            make.top.equalToSuperview().offset(6)
            make.right.lessThanOrEqualToSuperview().inset(8)
            make.height.equalTo(21)
        }

        subtitleLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        subtitleLabel.textColor = UIColor(hex: 0x9B9B9B)
        contentView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(1)
            make.bottom.equalToSuperview().inset(6)
            make.left.equalTo(titleLabel.snp.left)
            make.right.lessThanOrEqualToSuperview().inset(8)
            make.height.equalTo(18)
        }
    }

    func setup(with item: MKMapItem) {
        titleLabel.text = item.name
        subtitleLabel.text = item.placemark.title
    }

    required init?(coder _: NSCoder) {
        fatalError("NSCoder has not been implemented for DestinationSearchResultTableViewCell")
    }
}
