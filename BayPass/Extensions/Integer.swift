//
//  Integer.swift
//  BayPass
//
//  Created by Tim Roesner on 4/20/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import Foundation

extension Int {
    func secondsToTuple() -> (Int, Int, Int) {
        let minutes = (self / 60) % 60
        let hours = (self / 3600) % 24
        let days = self / 3600 / 24
        
        return (days, hours, minutes)
    }
    
    func durationToStringShort() -> String {
        let (days,hours,minutes) = self.secondsToTuple()
        var result = ""
        
        if days != 0 {
            result += "\(days)d "
        }
        if hours != 0 {
            result += "\(hours)h "
        }
        if minutes != 0 {
            result += "\(minutes)m"
        }
        return result.trimmingCharacters(in: .whitespaces)
    }
}
