//
//  StationTableViewCell.swift
//  BayPass
//
//  Created by Ayesha Khan on 4/18/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import UIKit

class LineTableViewCell: UITableViewCell {
    var gradientLayer = CAGradientLayer()
    let lineName = UILabel()
    let backView = UIView()
    let iconImageView = UIImageView()
    let timeLabels = [UILabel(), UILabel(), UILabel()]
    let frequencyLabel = UILabel()

    override init(style _: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCell.CellStyle.value1, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    override func layoutSubviews() {
        gradientLayer.frame = bounds
    }

    func setup(with tuple: (line: Line, departureTimes: [Date])) {
        if tuple.line.color.isLight() {
            gradientLayer = CAGradientLayer(leftColor: tuple.line.color.darker(by: 5.0) ?? .blue, rightColor: tuple.line.color.darker(by: 20.0) ?? .blue)
        } else {
            gradientLayer = CAGradientLayer(leftColor: tuple.line.color, rightColor: tuple.line.color.lighter(by: 10.0) ?? .blue)
        }
        backView.layer.insertSublayer(gradientLayer, at: 0)
        
        iconImageView.image = tuple.line.getIcon()
        if tuple.line.destination.contains(tuple.line.name) {
            lineName.text = tuple.line.destination
        } else {
           lineName.text = "\(tuple.line.name) to \(tuple.line.destination)"
        }
        for index in 0 ..< min(tuple.departureTimes.count, 3) {
            timeLabels[index].text = tuple.departureTimes[index].timeShort()
        }
        let frequencyInMinutes = tuple.departureTimes[safe: 0]?.duration(to: tuple.departureTimes[safe: 1] ?? Date()) ?? "?? min"
        frequencyLabel.text = "Every \(frequencyInMinutes)"
    }
    
    private func setupViews() {
        backView.layer.cornerRadius = 12
        backView.clipsToBounds = true
        backView.layer.backgroundColor = UIColor.blue.cgColor
        addSubview(backView)
        backView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(10)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        
        iconImageView.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        backView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.size.equalTo(25)
            make.left.top.equalToSuperview().inset(6)
        }
        
        for (index, label) in timeLabels.enumerated() {
            label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            label.textAlignment = .right
            let isFirst = index == 0
            label.font = isFirst ? UIFont.systemFont(ofSize: 15, weight: .bold) : UIFont.systemFont(ofSize: 12, weight: .regular)
            
            backView.addSubview(label)
            label.snp.makeConstraints { make in
                make.right.equalToSuperview().inset(12)
                make.width.equalTo(70)
                
                if isFirst {
                    make.centerY.equalTo(iconImageView)
                } else {
                    make.top.equalTo(timeLabels[index-1].snp.bottom).offset(2)
                }
            }
        }
        
        lineName.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        lineName.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        backView.addSubview(lineName)
        lineName.snp.makeConstraints { make in
            make.left.equalTo(iconImageView.snp.right).offset(4)
            make.centerY.equalTo(iconImageView)
            make.right.equalTo(timeLabels.first!.snp.left)
        }
        
        frequencyLabel.textColor = .white
        frequencyLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        backView.addSubview(frequencyLabel)
        frequencyLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().inset(16)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        gradientLayer.removeFromSuperlayer()
    }

    required init?(coder _: NSCoder) {
        print("NSCoder not supported in LineTableViewCell")
        return nil
    }
}
