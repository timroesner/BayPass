//
//  TicketManager.swift
//  BayPass
//
//  Created by Tim Roesner on 4/14/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import Foundation

class TicketManager {
    static let shared = TicketManager()
    private var calTrainStations = [String: Int]()
    private var bartStations = [String: String]()

    init() {
        fetchAllData()
    }

    func fetchAllData() {
        fetchBARTStations()
        fetchCalTrainStations()
    }

    private func fetchCalTrainStations() {}

    private func fetchBARTStations() {
        BART().getAllStations(completion: { stations in
            self.bartStations = stations
        })
    }

    func getDropDownOptions(for agency: Agency) -> [(title: String, values: [String])] {
        var dropDownOptions = [(title: String, values: [String])]()

        switch agency {
        case .BART:
            dropDownOptions.append((title: "Ticket Type", values: ["Single Ride", "Roundtrip"]))
            dropDownOptions.append((title: "From", values: bartStations.map { $0.key }.sorted()))
            dropDownOptions.append((title: "To", values: bartStations.map { $0.key }.sorted()))
        default:
            break
        }
        dropDownOptions.append((title: "Payment Method", values: PaymentMethod.allCases.map { $0.rawValue }))
        return dropDownOptions
    }

    func getBARTPrice(from: String, to: String, completion: @escaping (Double) -> Void) {
        guard let fromAbbr = bartStations[from],
            let toAbbr = bartStations[to]
        else { return }

        BART().getFare(from: fromAbbr, to: toAbbr) { fare in
            completion(fare)
        }
    }

    func calculateCalTrainZones(from: String, to: String) -> Int {
        guard let fromZone = calTrainStations[from],
            let toZone = calTrainStations[to]
        else {
            print("Could not find stations")
            return 0
        }
        return abs(fromZone - toZone) + 1
    }
}
