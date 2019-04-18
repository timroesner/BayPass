//
//  CPCollectionView.swift
//  BayPass
//
//  Created by Zhe Li on 4/15/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import UIKit

extension ClipperPassViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        if collectionView == clipperPassCollectionView {
            return agencies.count
        } else {
            return UserManager.shared.getValidPasses().count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == clipperPassCollectionView {
            let cell = clipperPassCollectionView.dequeueReusableCell(withReuseIdentifier: clipperPassCollectionViewCellID, for: indexPath) as! ClipperPassCollectionViewCell
            cell.setup(with: Pass(name: agencies[indexPath.row].stringValue,
                                  duration: DateInterval(start: Date(timeIntervalSinceNow: -470_482.0), end: Date(timeIntervalSinceNow: 470_482.0)),
                                  price: 0.0,
                                  validOnAgency: agencies[indexPath.row]))
            return cell
        } else {
            let cell = recentlyPurchasedClipperPassCollectionView.dequeueReusableCell(withReuseIdentifier: recentlyPurchasedClipperPassCollectionViewCellID, for: indexPath) as! ClipperPassCollectionViewCell
            cell.setup(with: UserManager.shared.getValidPasses()[indexPath.row])
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, insetForSectionAt _: Int) -> UIEdgeInsets {
        if collectionView == clipperPassCollectionView {
            return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        } else {
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 15)
        }
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, minimumInteritemSpacingForSectionAt _: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        if collectionView == clipperPassCollectionView {
            return CGSize(width: 160, height: 85)
        } else {
            return CGSize(width: 250, height: 140)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == clipperPassCollectionView {
            let clipperPassCheckoutViewController = ClipperPassCheckoutViewController()
            clipperPassCheckoutViewController.agency = agencies[indexPath.row]
            navigationController?.pushViewController(clipperPassCheckoutViewController, animated: true)
        } else if collectionView == recentlyPurchasedClipperPassCollectionView {
            let clipperPassCheckoutViewController = ClipperPassCheckoutViewController()
            clipperPassCheckoutViewController.agency = UserManager.shared.getValidPasses()[indexPath.row].validOnAgency
            navigationController?.pushViewController(clipperPassCheckoutViewController, animated: true)
        }
    }
}
