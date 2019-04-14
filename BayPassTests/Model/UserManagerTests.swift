//
//  UserManagerTests.swift
//  BayPassTests
//
//  Created by Tim Roesner on 4/6/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

@testable import BayPass
import XCTest

class UserManagerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testClipperFlow() {
        let card = ClipperCard(number: 1111111111, cashValue: 5.00, passes: [])
        UserManager.shared.setClipperCard(card: card)
        XCTAssertEqual(UserManager.shared.getClipperCard()?.cashValue, 5.00)
        
        UserManager.shared.addCashToCard(amount: 4.00)
        XCTAssertEqual(UserManager.shared.getClipperCard()?.cashValue, 9.00)
        
        UserManager.shared.removeCard()
        XCTAssertNil(UserManager.shared.getClipperCard())
    }
    
    func testGetValidPasses() {
        let calTrain = Agency.CalTrain
        let testCard = ClipperCard(number: 9999999999, cashValue: 0.0, passes: [Pass(name: "Monthly", duration: DateInterval(start: Date(), duration: 36000), price: 45.0, validOnAgency: calTrain)])
        UserManager.shared.setClipperCard(card: testCard)
        let validPasses = UserManager.shared.getValidPasses()
        XCTAssertEqual(validPasses.count, 1)
        UserManager.shared.removeCard()
    }
    
    func testTicketFlow() {
        UserManager.shared.clearAllPurchasedTickets()
        let ticket1 = Ticket(name: "Single Ride", count: 1, price: 2.50, validOnAgency: .VTA)
        let ticket2 = Ticket(name: "Day Pass", duration: DateInterval(start: Date(), duration: 86400), price: 12.00, validOnAgency: .Muni)
        let ticket3 = Ticket(name: "Monthly Pass", duration: DateInterval(start: Date().addingTimeInterval(3600), duration: 2592000), price: 260.0, validOnAgency: .CalTrain)
        
        UserManager.shared.addPurchased(ticket: ticket1)
        UserManager.shared.addPurchased(ticket: ticket2)
        UserManager.shared.addPurchased(ticket: ticket3)
        
        let purchasedTickets = UserManager.shared.getPurchasedTickets()
        XCTAssertEqual(purchasedTickets.count, 3)
        XCTAssertEqual(purchasedTickets, [ticket1, ticket3, ticket2])
        
        UserManager.shared.clearAllPurchasedTickets()
        XCTAssert(UserManager.shared.getPurchasedTickets().isEmpty)
    }
    
    func testSave() {
        UserManager.shared.save()
    }
    
    func testLoad() {
        UserManager.shared.load()
    }
}
