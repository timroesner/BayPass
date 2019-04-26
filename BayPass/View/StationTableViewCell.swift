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
    private(set) var lineTransitIconImage = UIImageView()
    private(set) var lineNameLabel = UILabel()
    private(set) var lineTimingsLabel = UILabel()
    private(set) var lineReoccuringTimeLabel = UILabel()
    private(set) var lineView = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(with _: Line?) {}
}
