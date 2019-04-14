//
//  ticketCarouselViewCellTests.swift
//  BayPassTests
//
//  Created by Zhe Li on 4/13/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

@testable import BayPass
import SnapKit
import XCTest

class ticketCarouselViewCellTests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSetup() {
        let ticketView = TicketView(agency: "VTA", icon: UIImage(named: "Tram")!, cornerRadius: 8)

        let cell = TicketCarouselViewCell()
        cell.setup(with: ticketView)

        XCTAssertEqual(cell.ticketView.nameLbl.text, "VTA")
        assert(cell.ticketView.imageView.image == UIImage(named: "Tram"))
        assert(cell.ticketView.nameLbl.font == UIFont.systemFont(ofSize: 24, weight: .bold))
    }
}
