//
//  CPCollectionView.swift
//  BayPass
//
//  Created by Zhe Li on 4/15/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import UIKit

extension ClipperPassViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        if(collectionView == self.clipperPassCollectionView){
            return agencies.count
        }else if(collectionView == self.recentlyPurchasedClipperPassCollectionView){
            return UserManager.shared.getValidPasses().count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == self.clipperPassCollectionView){
            let cell = clipperPassCollectionView.dequeueReusableCell(withReuseIdentifier: clipperPassCollectionViewCellID, for: indexPath) as! ClipperPassCollectionViewCell
            cell.backgroundColor = .white
            cell.setup(with: Pass(name: agencies[indexPath.row].stringValue,
                                  duration: DateInterval(start: Date(timeIntervalSinceNow: -470_482.0), end: Date(timeIntervalSinceNow: 470_482.0)),
                                  price: 0.0,
                                  validOnAgency: agencies[indexPath.row]))
            return cell
        }else if(collectionView == self.recentlyPurchasedClipperPassCollectionView){
            let cell = recentlyPurchasedClipperPassCollectionView.dequeueReusableCell(withReuseIdentifier: recentlyPurchasedClipperPassCollectionViewCellID, for: indexPath) as! ClipperPassCollectionViewCell
            cell.backgroundColor = .white
            cell.setup(with: UserManager.shared.getValidPasses()[indexPath.row])
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, insetForSectionAt _: Int) -> UIEdgeInsets {
        if(collectionView == self.clipperPassCollectionView){
            return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        }else if(collectionView == self.recentlyPurchasedClipperPassCollectionView){
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 15)
        }
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        //return CGSize(width: (self.view.frame.size.width - 90) / 2, height: (self.view.frame.size.width - 90) * 0.28)
        if(collectionView == self.clipperPassCollectionView){
            return CGSize(width: 160, height: 85)
        }else if(collectionView == self.recentlyPurchasedClipperPassCollectionView){
            return CGSize(width: 250, height: 140)
        }
        
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(collectionView == self.clipperPassCollectionView){
            let clipperPassCheckoutViewController = ClipperPassCheckoutViewController()
            clipperPassCheckoutViewController.agency = agencies[indexPath.row]
            navigationController?.pushViewController(clipperPassCheckoutViewController, animated: true)
        }else if(collectionView == self.recentlyPurchasedClipperPassCollectionView){
            let clipperPassCheckoutViewController = ClipperPassCheckoutViewController()
            clipperPassCheckoutViewController.agency = UserManager.shared.getValidPasses()[indexPath.row].validOnAgency
            navigationController?.pushViewController(clipperPassCheckoutViewController, animated: true)
        }
    }
    
}
