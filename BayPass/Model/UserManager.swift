//
//  ClipperSingleton.swift
//  BayPass
//
//  Created by Tim Roesner on 3/29/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import Disk
import Foundation

class UserManager {
    static let shared = UserManager()
    private var clipperCard: ClipperCard?
    private var purchasedTickets = [Ticket]()

    // MARK: Clipper functions

    func getClipperCard() -> ClipperCard? {
        return clipperCard
    }

    func setClipperCard(card: ClipperCard) {
        clipperCard = card
    }

    func removeCard() {
        clipperCard = nil
    }

    func addCashToCard(amount: Double) {
        clipperCard?.addCash(amount: amount)
    }
    
    //----------------
    func addPass(pass: Pass) {
        clipperCard?.passes.append(pass)
    }
    //---------------

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

    // MARK: Purchased Tickets functions

    func getPurchasedTickets() -> [Ticket] {
        purchasedTickets.sort(by: { (first, second) -> Bool in
            if first.count > 0 {
                return true
            }

            if let firstDuration = first.duration,
                let secondDuration = second.duration {
                return firstDuration.start.compare(secondDuration.start) == ComparisonResult.orderedDescending
            } else {
                return false
            }
        })
        return purchasedTickets
    }

    func addPurchased(ticket: Ticket) {
        purchasedTickets.append(ticket)
    }

    func clearAllPurchasedTickets() {
        purchasedTickets.removeAll()
    }

    // MARK: Persistent Storage

    func save() {
        do {
            try Disk.save(clipperCard, to: .documents, as: "clipperCard.json")
            try Disk.save(purchasedTickets, to: .documents, as: "purchasedTickets.json")
            print("Successfully saved user data")
        } catch {
            print(error)
        }
    }

    func load() {
        do {
            clipperCard = try? Disk.retrieve("clipperCard.json", from: .documents, as: ClipperCard.self)
            purchasedTickets = try Disk.retrieve("purchasedTickets.json", from: .documents, as: [Ticket].self)
            print("Read existing user data")
        } catch {
            print(error)
        }
    }
}
