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

    func credentials() -> String {
        if !ProcessInfo.processInfo.environment.isEmpty {
            return ProcessInfo.processInfo.environment[self]!
        } else {
            return Credentials().dict[self] ?? "Token not found"
        }
    }
}
