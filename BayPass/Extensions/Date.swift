//
//  Date.swift
//  BayPass
//
//  Created by Tim Roesner on 3/4/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import Foundation

extension Date {
    func duration(to date: Date) -> String {
        let dateComponentsFormatter = DateComponentsFormatter()
        dateComponentsFormatter.allowedUnits = [.day, .hour, .minute]
        dateComponentsFormatter.unitsStyle = .abbreviated
        return dateComponentsFormatter.string(from: self, to: date) ?? ""
    }

    func timeShort() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: self)
    }
}
