//
//  ClipperSingleton.swift
//  BayPass
//
//  Created by Tim Roesner on 3/29/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import Foundation

class ClipperManager {
    
    static let shared = ClipperManager()
    private var clipperCard: ClipperCard?

    func getClipperCard() -> ClipperCard? {
        return clipperCard
    }

    func setClipperCard(card: ClipperCard) {
        clipperCard = card
    }

    func getValidPasses() -> [Pass] {
        var result = [Pass]()
        let now = Date()

        for pass in clipperCard?.passes ?? [] {
            if pass.duration.end >= now, pass.duration.start <= now {
                result.append(pass)
            }
        }
        return result
    }
}
