//
//  ClipperSingleton.swift
//  BayPass
//
//  Created by Tim Roesner on 3/29/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import Foundation

class ClipperSingleton {
    private var clipperCard: ClipperCard?

    func getClipperCard() -> ClipperCard? {
        return clipperCard
    }

    func setClipperCard(card: ClipperCard) {
        clipperCard = card
    }
}
