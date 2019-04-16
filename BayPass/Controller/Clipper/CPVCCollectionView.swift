//
//  CPVCCollectionView.swift
//  BayPass
//
//  Created by Zhe Li on 4/15/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import UIKit

extension ClipperPassViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return agencies.count
    }
    
    func collectionView(_: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = clipperPassCollectionView.dequeueReusableCell(withReuseIdentifier: clipperPassCollectionViewCellID, for: indexPath) as! ClipperPassCollectionViewCell
        cell.backgroundColor = .white
        //cell.setup(with: TicketView(agency: agencies[indexPath.row].stringValue, icon: agencies[indexPath.row].getIcon(), cornerRadius: 12))
        cell.setup(with: Pass(name: agencies[indexPath.row].stringValue,
                              duration: DateInterval(start: Date(timeIntervalSinceNow: -470_482.0), end: Date(timeIntervalSinceNow: 470_482.0)),
                              price: 0.0,
                              validOnAgency: agencies[indexPath.row]))
        return cell
    }
    
    
    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, insetForSectionAt _: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        //return CGSize(width: (self.view.frame.size.width - 90) / 2, height: (self.view.frame.size.width - 90) * 0.28)
        return CGSize(width: 160, height: 85)
    }
    
    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let ticketCheckoutViewController = TicketCheckoutViewController()
        //ticketCheckoutViewController.agency = agencies[indexPath.row]
        //navigationController?.pushViewController(ticketCheckoutViewController, animated: true)
    }
  
}
