//
//  TicketManager.swift
//  BayPass
//
//  Created by Tim Roesner on 4/14/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import Foundation
import Alamofire

class TicketManager {
    static let shared = TicketManager()
    private var calTrainStations = [String: Int]()
    private var bartStations = [String: String]()
    private var tickets = [String: [String: [String: Any]]]()

    init() {
        fetchAllData()
    }

    func fetchAllData() {
        fetchBARTStations()
        fetchCalTrainStations()
        Alamofire.request("https://timroesner.com/baypass/tickets.json").responseJSON { (response) in
            if let tickets = response.result.value as? [String: [String: [String: Any]]] {
                self.tickets = tickets
            }
        }
    }

    private func fetchCalTrainStations() {
        Alamofire.request("https://timroesner.com/baypass/calTrainStations.json").responseJSON { (response) in
            if let stations = response.result.value as? [String: Int] {
                self.calTrainStations = stations
            }
        }
    }

    private func fetchBARTStations() {
        BART().getAllStations(completion: { stations in
            self.bartStations = stations
        })
    }

    func getDropDownOptions(for agency: Agency, onlyPasses: Bool) -> [(title: String, values: [String])] {
        var dropDownOptions = [(title: String, values: [String])]()
        
        var ticketTypes = (title: "Ticket Type", values: [String]())
        if onlyPasses {
            ticketTypes.values = tickets[agency.stringValue]?.filter{ $0.value["count"] == nil }.map{ $0.key }.sorted() ?? []
        } else {
            ticketTypes.values = tickets[agency.stringValue]?.map{ $0.key }.sorted() ?? []
        }

        switch agency {
        case .BART:
            dropDownOptions.append((title: "Ticket Type", values: onlyPasses ? ["Roundtrip"] : ["Single Ride", "Roundtrip"]))
            dropDownOptions.append((title: "From", values: bartStations.map { $0.key }.sorted()))
            dropDownOptions.append((title: "To", values: bartStations.map { $0.key }.sorted()))
        case .CalTrain:
            dropDownOptions.append(ticketTypes)
            dropDownOptions.append((title: "From", values: calTrainStations.map { $0.key }.sorted()))
            dropDownOptions.append((title: "To", values: calTrainStations.map { $0.key }.sorted()))
        default:
            dropDownOptions.append(ticketTypes)
            if let subTypes = tickets[agency.stringValue]?["Single Ride"]?["price"] as? [String: Any] {
                dropDownOptions.append((title: "Sub Type", values: subTypes.map{$0.key}.sorted()))
            }
        }
        dropDownOptions.append((title: "Payment Method", values: PaymentMethod.allCases.map { $0.rawValue }))
        return dropDownOptions
    }

    func getBARTPrice(from: String, to: String, completion: @escaping (Double) -> Void) {
        print("\(from) \(bartStations[from])")
        print("\(to) \(bartStations[to])")
        print(bartStations)
        guard let fromAbbr = bartStations[from],
            let toAbbr = bartStations[to]
        else { return }
        
        BART().getFare(from: fromAbbr, to: toAbbr) { fare in
            completion(fare)
        }
    }

    func getCalTrainPrice(ticketType: String, from: String, to: String) -> Double? {
        guard let fromZone = calTrainStations[from],
            let toZone = calTrainStations[to]
        else {
            print("Could not find stations")
            return nil
        }
        let zones = abs(fromZone - toZone) + 1
        if let prices = tickets["CalTrain"]?[ticketType]?["price"] as? [String: Double],
        let price = prices[String(zones)] {
            return price
        } else {
            return nil
        }
    }
    
    func getTicketPrice(agency: Agency, ticketType: String, subType: String?) -> Double? {
        if let subType = subType {
            return (tickets[agency.stringValue]?[ticketType]?["price"] as? [String: Double])?[subType]
        } else {
            return tickets[agency.stringValue]?[ticketType]?["price"] as? Double
        }
    }
}
