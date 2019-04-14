//
//  StationSearchResultTableViewCell.swift
//  BayPass
//
//  Created by Tim Roesner on 2/26/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import SnapKit
import UIKit

class StationSearchResultTableViewCell: UITableViewCell {
    private(set) var iconView = UIImageView()
    private(set) var title = UILabel()
    private(set) var lineView = UIView()

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(iconView)
        iconView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.top.equalToSuperview().inset(9)
            make.bottom.equalToSuperview().inset(9)
            make.width.equalTo(iconView.snp.height)
        }

        title.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        contentView.addSubview(title)
        title.snp.makeConstraints { make in
            make.left.equalTo(iconView.snp.right).offset(14)
            make.height.equalTo(21)
            make.top.equalToSuperview().inset(7)
            make.right.greaterThanOrEqualToSuperview().inset(8)
        }

        contentView.addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(4)
            make.left.equalTo(title.snp.left)
            make.right.greaterThanOrEqualToSuperview().inset(8)
            make.height.equalTo(15)
            make.bottom.equalToSuperview().inset(9)
        }
    }

    func setup(with station: Station) {
        title.text = station.name
        iconView.tintColor = UIColor(hex: 0x9B9B9B)
        iconView.image = station.getIcon()
        if station.name.last == ")" {
            let newStationName = station.name.dropLast(3)
            title.text = newStationName.description
        }
        let noNewLines = station.lines.filterDuplicate { ($0.name) }

        setLineView(with: noNewLines)
    }

    private func setLineView(with lines: [Line]) {
        var lineLabels = [UILabel]()

        for index in 0 ..< min(lines.count, 5) {
            let lineLabel = UILabel()

            lineLabel.layer.cornerRadius = 4
            lineLabel.textAlignment = .center
            lineLabel.textColor = .white

            if index == 4 {
                lineLabel.font = UIFont.systemFont(ofSize: 14, weight: .black)
                lineLabel.layer.backgroundColor = UIColor(hex: 0x9B9B9B).cgColor
                lineLabel.text = "＋"
            } else {
                lineLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
                lineLabel.layer.backgroundColor = lines[index].color.cgColor
                if lines[index].color.isLight() == true {
                    lineLabel.textColor = .black
                }
                lineLabel.text = lines[index].name
            }

            lineView.addSubview(lineLabel)
            lineLabel.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.bottom.equalToSuperview()
                if let previous = lineLabels.last {
                    make.left.equalTo(previous.snp.right).offset(4)
                } else {
                    make.left.equalToSuperview()
                }
                make.width.equalTo(32)
            }
            lineLabels.append(lineLabel)
        }
    }

    override func prepareForReuse() {
        for view in lineView.subviews {
            view.removeFromSuperview()
        }
    }

    required init?(coder _: NSCoder) {
        print("NSCoder not supported in StationSearchResultTableViewCell")
        return nil
    }
}
