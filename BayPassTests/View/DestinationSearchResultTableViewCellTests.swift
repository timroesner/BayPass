//
//  DestinationSearchResultTableViewCellTests.swift
//  BayPassTests
//
//  Created by Tim Roesner on 2/27/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

@testable import BayPass
import XCTest
import MapKit
import Contacts

class DestinationSearchResultTableViewCellTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSetup() {
        let coordinates = CLLocationCoordinate2DMake(37.3317, 122.0302)
        let address = [CNPostalAddressStreetKey: "1 Infinite Loop", CNPostalAddressCityKey: "Cupertino", CNPostalAddressStateKey: "CA", CNPostalAddressPostalCodeKey: "95014"]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: address)
        let item = MKMapItem(placemark: placemark)
        item.name = "Apple Campus"
        
        let cell = DestinationSearchResultTableViewCell()
        cell.setup(with: item)
        XCTAssertEqual(cell.titleLabel.text, "Apple Campus")
        XCTAssertEqual(cell.subtitleLabel.text, "1 Infinite Loop Cupertino CA 95014 United States")
        XCTAssertEqual(cell.iconView.image, UIImage(named: "MapMarker"))
    }

}
