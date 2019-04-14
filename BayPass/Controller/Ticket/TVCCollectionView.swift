//
//  TVCCollectionView.swift
//  BayPass
//
//  Created by Tim Roesner on 4/14/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import UIKit

extension TicketViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return agencies.count
    }
    
    func collectionView(_: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = ticketCarouselView.dequeueReusableCell(withReuseIdentifier: ticketCarouselViewCellID, for: indexPath) as! TicketCarouselViewCell
        cell.backgroundColor = .white
        cell.setup(with: TicketView(agency: agencies[indexPath.row].stringValue, icon: agencies[indexPath.row].getIcon(), cornerRadius: 12))
        return cell
    }
    
    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        return CGSize(width: 135, height: 200)
    }
    
    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, insetForSectionAt _: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    }
    
    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let ticketCheckoutViewController = TicketCheckoutViewController()
        ticketCheckoutViewController.agency = agencies[indexPath.row]
        navigationController?.pushViewController(ticketCheckoutViewController, animated: true)
    }
}
