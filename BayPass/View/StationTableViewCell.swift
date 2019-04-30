//
//  StationTableViewCell.swift
//  BayPass
//
//  Created by Ayesha Khan on 4/18/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import UIKit

class StationTableViewCell: UITableViewCell {
    var theLine: Line?
    private(set) var lineTransitIconImage = UIImageView()
    private(set) var lineNameLabel = UILabel()
    private(set) var lineTimingsLabel = UILabel()
    private(set) var lineReoccuringTimeLabel = UILabel()
    private(set) var card: UIView = {
        var view = UIView()
        view.layer.cornerRadius = 15
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(with line: Line?) {
        theLine = line
        lineTransitIconImage.image = line?.getIcon()
        addSubview(card)
    }
}
