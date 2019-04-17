//
//  GoogleFirestore.swift
//  BayPass
//
//  Created by Hua Tong on 3/18/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import Alamofire
import Firebase
import FirebaseFirestore
import Foundation

class GoogleFirestore {
    static let shared = GoogleFirestore()

    func configure() {
        FirebaseApp.configure()
    }

    func reference(to collectionReference: String) -> CollectionReference {
        return Firestore.firestore().collection(collectionReference)
    }

    func getTicketList(agency: Agency, completion: @escaping (([Ticket], [Pass])) -> Void) {
        var tickets = [Ticket]()
        var passes = [Pass]()
        reference(to: "Agencies").document(agency.stringValue).addSnapshotListener { snapshot, _ in
            guard let snapshot = snapshot else { return }

            for ticket in snapshot.data() as [String: AnyObject]? ?? [:] {
                let ticketName = ticket.key
                let ticketValue = ticket.value as? [String: Any] ?? [:]
                let count = ticketValue["count"] as? Int
                let duration = ticketValue["duration"] as? Int
                let price = ticketValue["price"] as? Double

                // print out data
                print(agency.stringValue)
                print(snapshot.data() as [String: AnyObject]? ?? [:])
                
                if let price = price {
                    if let count = count {
                        let newTicket = Ticket(name: ticketName, count: count, price: price, validOnAgency: agency)
                        tickets.append(newTicket)
                    } else if let duration = duration {
                        let interval = DateInterval(start: Date(), duration: TimeInterval(duration * 3600))

                        let newPass = Pass(name: ticketName, duration: interval, price: price, validOnAgency: agency)
                        let newTicket = Ticket(name: ticketName, duration: interval, price: price, validOnAgency: agency)
                        tickets.append(newTicket)
                        passes.append(newPass)
                    }
                } else {
                    if let priceArray = ticketValue["price"] as? [String: Double] {
                        for (priceName, priceValue) in priceArray {
                            let newName = ticketName + " (" + priceName + ")"
                            if let count = count {
                                let newTicket = Ticket(name: newName, count: count, price: priceValue, validOnAgency: agency)
                                tickets.append(newTicket)
                            } else if let duration = duration {
                                let interval = DateInterval(start: Date(), duration: TimeInterval(duration * 3600))
                                let newPass = Pass(name: newName, duration: interval, price: priceValue, validOnAgency: agency)
                                let newTicket = Ticket(name: newName, duration: interval, price: priceValue, validOnAgency: agency)
                                tickets.append(newTicket)
                                passes.append(newPass)
                            }
                        }
                    }
                }
            }
            completion((tickets, passes))
        }
    }
}
