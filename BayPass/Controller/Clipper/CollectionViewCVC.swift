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
        return clipperManager.getValidPasses().count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ClipperPassCollectionViewCell

        if indexPath.row == 0 {
            cell.setupAdd()
        } else {
            cell.setup(with: clipperManager.getValidPasses()[indexPath.row - 1])
        }
        return cell
    }

    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            // present add pass UI
            navigationController?.pushViewController(ClipperAddCashViewController(), animated: true)
        } else {
            // present pass details with selected pass
            let pass = clipperManager.getValidPasses()[indexPath.row - 1]
            print(pass)
            navigationController?.pushViewController(ClipperAddCashViewController(), animated: true)
        }
    }
}
