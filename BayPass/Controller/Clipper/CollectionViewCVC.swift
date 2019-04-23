//
//  CollectionViewCVC.swift
//  BayPass
//
//  Created by Tim Roesner on 3/28/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import UIKit

extension ClipperViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        if collectionView.bounds.height < 125 {
            return CGSize(width: collectionView.bounds.height * 1.25, height: collectionView.bounds.height)
        } else {
            return CGSize(width: collectionView.bounds.height * 0.68, height: collectionView.bounds.height)
        }
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return UserManager.shared.getValidPasses().count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ClipperPassCollectionViewCell

        if indexPath.row == 0 {
            cell.setupAdd()
        } else {
            cell.setup(with: UserManager.shared.getValidPasses()[indexPath.row - 1])
        }
        return cell
    }

    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            navigationController?.pushViewController(ClipperPassViewController(), animated: true)
        } else {
            let pass = UserManager.shared.getValidPasses()[indexPath.row - 1]
            let ticketDetailViewController = TicketDetailViewController(pass: pass)
            bottomSheet.viewControllers = [ticketDetailViewController]
            bottomSheet.modalPresentationStyle = .overCurrentContext
            present(bottomSheet, animated: true, completion: nil)
            bottomSheet.moveOverlay(toNotchAt: 1, animated: true)
        }
    }
}
