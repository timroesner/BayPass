//
//  TicketViewTests.swift
//  BayPassTests
//
//  Created by Tim Roesner on 11/14/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

@testable import BayPass
import SnapKit
import XCTest

class TicketViewTests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test85x125() {
        let ticketView = TicketView(agency: Agency.VTA, icon: UIImage(named: "Tram")!, cornerRadius: 8)
        let view = UIView()
        view.addSubview(ticketView)
        ticketView.snp.makeConstraints({ (make) -> Void in
            make.width.equalTo(85)
            make.height.equalTo(125)
        })
        ticketView.layoutIfNeeded()
        let gradientColors = ticketView.gradient.colors as? [CGColor]
        assert(gradientColors == [UIColor(named: "lightVTA")!.cgColor, UIColor(named: "darkVTA")!.cgColor])
        assert(ticketView.gradient.cornerRadius == 8)
        assert(ticketView.nameLbl.font == UIFont.systemFont(ofSize: 14, weight: .bold))
        assert(ticketView.nameLbl.text == "VTA")
        assert(ticketView.imageView.image == UIImage(named: "Tram"))
    }

    func test95x60() {
        let ticketView = TicketView(agency: Agency.ACTransit, icon: UIImage(named: "Bus")!, cornerRadius: 8)
        let view = UIView()
        view.addSubview(ticketView)
        ticketView.snp.makeConstraints({ (make) -> Void in
            make.width.equalTo(95)
            make.height.equalTo(60)
        })
        ticketView.layoutIfNeeded()
        let gradientColors = ticketView.gradient.colors as? [CGColor]
        assert(gradientColors == [UIColor(named: "lightACTransit")!.cgColor, UIColor(named: "darkACTransit")!.cgColor])
        assert(ticketView.gradient.cornerRadius == 8)
        assert(ticketView.nameLbl.font == UIFont.systemFont(ofSize: 15, weight: .bold))
        assert(ticketView.nameLbl.text == "AC Transit")
        assert(ticketView.imageView.image == UIImage(named: "Bus"))
    }

    func test135x200() {
        let ticketView = TicketView(agency: Agency.ACE, icon: UIImage(named: "CalTrain")!, cornerRadius: 12)
        let view = UIView()
        view.addSubview(ticketView)
        ticketView.snp.makeConstraints({ (make) -> Void in
            make.width.equalTo(135)
            make.height.equalTo(200)
        })
        ticketView.layoutIfNeeded()
        let gradientColors = ticketView.gradient.colors as? [CGColor]
        assert(gradientColors == [UIColor(named: "lightACE")!.cgColor, UIColor(named: "darkACE")!.cgColor])
        assert(ticketView.gradient.cornerRadius == 12)
        assert(ticketView.nameLbl.font == UIFont.systemFont(ofSize: 24, weight: .bold))
        assert(ticketView.nameLbl.text == "ACE")
        assert(ticketView.imageView.image == UIImage(named: "CalTrain"))
    }

    func test160x85() {
        let ticketView = TicketView(agency: Agency.BART, icon: UIImage(named: "BART")!, cornerRadius: 8)
        let view = UIView()
        view.addSubview(ticketView)
        ticketView.snp.makeConstraints({ (make) -> Void in
            make.width.equalTo(160)
            make.height.equalTo(85)
        })
        ticketView.layoutIfNeeded()
        let gradientColors = ticketView.gradient.colors as? [CGColor]
        assert(gradientColors == [UIColor(named: "lightBART")!.cgColor, UIColor(named: "darkBART")!.cgColor])
        assert(ticketView.gradient.cornerRadius == 8)
        assert(ticketView.nameLbl.font == UIFont.systemFont(ofSize: 20, weight: .bold))
        assert(ticketView.nameLbl.text == "BART")
        assert(ticketView.imageView.image == UIImage(named: "BART"))
    }

    func test250x140() {
        let ticketView = TicketView(agency: Agency.CalTrain, icon: UIImage(named: "CalTrain")!, cornerRadius: 8)
        let view = UIView()
        view.addSubview(ticketView)
        ticketView.snp.makeConstraints({ (make) -> Void in
            make.width.equalTo(250)
            make.height.equalTo(140)
        })
        ticketView.layoutIfNeeded()
        let gradientColors = ticketView.gradient.colors as? [CGColor]
        assert(gradientColors == [UIColor(named: "lightCalTrain")!.cgColor, UIColor(named: "darkCalTrain")!.cgColor])
        assert(ticketView.gradient.cornerRadius == 8)
        assert(ticketView.nameLbl.font == UIFont.systemFont(ofSize: 30, weight: .bold))
        assert(ticketView.nameLbl.text == "CalTrain")
        assert(ticketView.imageView.image == UIImage(named: "CalTrain"))
    }

    func test335x190() {
        let ticketView = TicketView(agency: Agency.GoldenGateTransit, icon: UIImage(named: "Bus")!, cornerRadius: 8)
        let view = UIView()
        view.addSubview(ticketView)
        ticketView.snp.makeConstraints({ (make) -> Void in
            make.width.equalTo(335)
            make.height.equalTo(190)
        })
        ticketView.layoutIfNeeded()
        let gradientColors = ticketView.gradient.colors as? [CGColor]
        XCTAssertEqual(gradientColors, [UIColor(named: "lightGoldenGateTransit")!.cgColor, UIColor(named: "darkGoldenGateTransit")!.cgColor])
        XCTAssertEqual(ticketView.gradient.cornerRadius, 8)
        XCTAssertEqual(ticketView.nameLbl.font, UIFont.systemFont(ofSize: 46, weight: .bold))
        XCTAssertEqual(ticketView.nameLbl.text, "Golden Gate\nTransit")
        XCTAssertEqual(ticketView.imageView.image, UIImage(named: "Bus"))
    }

    func testHugeWidth() {
        let ticketView = TicketView(agency: Agency.ACTransit, icon: UIImage(named: "Bus")!, cornerRadius: 14)
        let view = UIView()
        view.addSubview(ticketView)
        ticketView.snp.makeConstraints({ (make) -> Void in
            make.width.equalTo(500)
            make.height.equalTo(300)
        })
        ticketView.layoutIfNeeded()
    }

    func testImaginaryAgency() {
        let ticketView = TicketView(agency: Agency.zero, icon: #imageLiteral(resourceName: "Bus"), cornerRadius: 12)
        assert(ticketView.gradient.colors?.count == 2)
    }
}
