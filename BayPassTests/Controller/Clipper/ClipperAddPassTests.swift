//
//  ClipperAddPassTests.swift
//  BayPassTests
//
//  Created by Tim Roesner on 4/17/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

@testable import BayPass
import XCTest

class ClipperAddPassTests: XCTestCase {
    
    override func setUp() {
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRecentlyPurchased() {
        let testCard = ClipperCard(number: 9_999_999_999, cashValue: 0.0, passes: [])
        UserManager.shared.setClipperCard(card: testCard)
        let pass = Pass(name: "Monthly Pass", duration: DateInterval(start: Date(timeIntervalSinceNow: -300), duration: 36000), price: 260.0, validOnAgency: .CalTrain)
        UserManager.shared.addPass(pass: pass)
        let vc = ClipperPassViewController()
        UIApplication.shared.keyWindow!.rootViewController = vc
        XCTAssertNotNil(UIApplication.shared.keyWindow?.rootViewController)
        
        let itemsCount = vc.collectionView(vc.recentlyPurchasedClipperPassCollectionView, numberOfItemsInSection: 0)
        XCTAssertEqual(itemsCount, 1)
        
        let cell = vc.collectionView(vc.recentlyPurchasedClipperPassCollectionView, cellForItemAt: IndexPath(row: 0, section: 0))
        XCTAssertNotNil(cell)
        
        let insets = vc.collectionView(vc.recentlyPurchasedClipperPassCollectionView, layout: vc.recentlyPurchasedClipperPassCollectionView.collectionViewLayout, insetForSectionAt: 0)
        XCTAssertEqual(insets, UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 15))
        
        let cellSize = vc.collectionView(vc.recentlyPurchasedClipperPassCollectionView, layout: vc.recentlyPurchasedClipperPassCollectionView.collectionViewLayout, sizeForItemAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(cellSize, CGSize(width: 250, height: 140))
        
        vc.collectionView(vc.recentlyPurchasedClipperPassCollectionView, didSelectItemAt: IndexPath(row: 0, section: 0))
        
        UserManager.shared.removeCard()
    }
    
    func testWithNewCard() {
        let testCard = ClipperCard(number: 9_999_999_999, cashValue: 0.0, passes: [])
        UserManager.shared.setClipperCard(card: testCard)
        let vc = ClipperPassViewController()
        UIApplication.shared.keyWindow!.rootViewController = vc
        XCTAssertNotNil(UIApplication.shared.keyWindow?.rootViewController)
        vc.collectionView(vc.clipperPassCollectionView, didSelectItemAt: IndexPath(row: 0, section: 0))
        UserManager.shared.removeCard()
    }

}
