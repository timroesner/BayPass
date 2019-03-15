//
//  NSDate.swift
//  BayPass
//
//  Created by Ayesha Khan on 3/11/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import Foundation

extension NSDate {
    func toDateTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let myString = formatter.string(from: Date()) // string purpose I add here
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = "dd-MMM-yyyy"
        let myStringafd = formatter.string(from: yourDate!)

        return myStringafd
    }
}
