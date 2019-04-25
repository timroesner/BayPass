//
//  StationTableViewCell.swift
//  BayPass
//
//  Created by Ayesha Khan on 4/18/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import UIKit

class StationTableViewCell: UITableViewCell {
    var line: Line?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup(with _: Line?) {}

    private let lineTransitIconImage: UIImageView = {
        UIImageView()
    }()

    private let lineNameLabel: UILabel = {
        UILabel()
    }()

    private let lineTimingsLabel: UILabel = {
        UILabel()
    }()

    private let lineReoccuringTimeLabel: UILabel = {
        UILabel()
    }()
}
