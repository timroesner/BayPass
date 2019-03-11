//
//  String.swift
//  BayPass
//
//  Created by Tim Roesner on 10/25/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }

    func toDateTime() -> NSDate {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let dateFromString: NSDate = dateFormatter.date(from: self)! as NSDate
        return dateFromString
    }
}
