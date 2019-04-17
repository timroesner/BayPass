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

    func getCurrentTimetoFormattedStringForHereAPI() -> String {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var formattedDate = format.string(from: date)
        var dateFormatArr = formattedDate.components(separatedBy: " ")
        let dateString = dateFormatArr[0]
        let timeString = dateFormatArr[1]

        formattedDate = dateString + "T" + timeString
        return formattedDate
    }
}
