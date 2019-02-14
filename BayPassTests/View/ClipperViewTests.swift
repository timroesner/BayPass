//
//  ClipperViewTests.swift
//  BayPassTests
//
//  Created by Zhe Li on 2/13/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

@testable import BayPass
import XCTest
import SnapKit

class ClipperViewTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test135x77() {
        let clipperView = ClipperView(cardNumber: 123456789, cashValue: 12.54)
        let view = UIView()
        view.addSubview(clipperView)
        clipperView.snp.makeConstraints({ (make) -> Void in
            make.width.equalTo(135)
            make.height.equalTo(77)
        })
        clipperView.layoutIfNeeded()
        let gradientColor1 = clipperView.gradient1.colors as? [CGColor]
        let gradientColor2 = clipperView.gradient2.colors as? [CGColor]
        
        assert(gradientColor1 == [UIColor(hex: 0x15224A).cgColor, UIColor(hex: 0x00648D).cgColor])
        assert(gradientColor2 == [UIColor(hex: 0x162D58).cgColor, UIColor(hex: 0x005580).cgColor])
        assert(clipperView.gradient1.cornerRadius == 12)
        assert(clipperView.gradient2.cornerRadius == 12)
        assert(clipperView.cashValueLbl.font == UIFont.systemFont(ofSize: 9, weight: .bold))
        assert(clipperView.cardNumberLbl.font == UIFont.systemFont(ofSize: 6, weight: .regular))
        assert(clipperView.cashValueLbl.text == "$12.54")
        assert(clipperView.cardNumberLbl.text == "•••• 6789")
    }
    
    func test250x142() {
        let clipperView = ClipperView(cardNumber: 987654321, cashValue: 120.78)
        let view = UIView()
        view.addSubview(clipperView)
        clipperView.snp.makeConstraints({ (make) -> Void in
            make.width.equalTo(250)
            make.height.equalTo(142)
        })
        clipperView.layoutIfNeeded()
        let gradientColor1 = clipperView.gradient1.colors as? [CGColor]
        let gradientColor2 = clipperView.gradient2.colors as? [CGColor]
        
        assert(gradientColor1 == [UIColor(hex: 0x15224A).cgColor, UIColor(hex: 0x00648D).cgColor])
        assert(gradientColor2 == [UIColor(hex: 0x162D58).cgColor, UIColor(hex: 0x005580).cgColor])
        assert(clipperView.gradient1.cornerRadius == 12)
        assert(clipperView.gradient2.cornerRadius == 12)
        assert(clipperView.cashValueLbl.font == UIFont.systemFont(ofSize: 14, weight: .bold))
        assert(clipperView.cardNumberLbl.font == UIFont.systemFont(ofSize: 10, weight: .regular))
        assert(clipperView.cashValueLbl.text == "$120.78")
        assert(clipperView.cardNumberLbl.text == "•••• 4321")
    }
    
    func test375x214() {
        let clipperView = ClipperView(cardNumber: 121212121, cashValue: 0.0)
        let view = UIView()
        view.addSubview(clipperView)
        clipperView.snp.makeConstraints({ (make) -> Void in
            make.width.equalTo(375)
            make.height.equalTo(214)
        })
        clipperView.layoutIfNeeded()
        let gradientColor1 = clipperView.gradient1.colors as? [CGColor]
        let gradientColor2 = clipperView.gradient2.colors as? [CGColor]
        
        assert(gradientColor1 == [UIColor(hex: 0x15224A).cgColor, UIColor(hex: 0x00648D).cgColor])
        assert(gradientColor2 == [UIColor(hex: 0x162D58).cgColor, UIColor(hex: 0x005580).cgColor])
        assert(clipperView.gradient1.cornerRadius == 12)
        assert(clipperView.gradient2.cornerRadius == 12)
        assert(clipperView.cashValueLbl.font == UIFont.systemFont(ofSize: 24, weight: .bold))
        assert(clipperView.cardNumberLbl.font == UIFont.systemFont(ofSize: 14, weight: .regular))
        assert(clipperView.cashValueLbl.text == "$0.00")
        assert(clipperView.cardNumberLbl.text == "•••• 2121")
    }
    
    func testChangingCashValue() {
        let clipperView = ClipperView(cardNumber: 121212121, cashValue: 0.0)
        let view = UIView()
        view.addSubview(clipperView)
        clipperView.snp.makeConstraints({ (make) -> Void in
            make.width.equalTo(375)
            make.height.equalTo(214)
        })
        clipperView.layoutIfNeeded()
        clipperView.setBalanceLbl(cashValue: 15.0)
        XCTAssertEqual(clipperView.cashValueLbl.text, "$15.00")
    }
    
}
