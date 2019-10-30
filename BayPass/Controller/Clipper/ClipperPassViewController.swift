//
//  ClipperPassViewController.swift
//  BayPass
//
//  Created by Zhe Li on 4/15/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import SnapKit
import UIKit

class ClipperPassViewController: UIViewController {
    let agenciesLbl = UILabel()
    let recentlyPurchasedLbl = UILabel()

    let clipperPassCollectionViewCellID = "clipperPassCollectionViewCellID"
    let clipperPassCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.backgroundColor = UIColor.white
        collection.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        collection.isScrollEnabled = true
        collection.showsVerticalScrollIndicator = false
        return collection
    }()

    let recentlyPurchasedClipperPassCollectionViewCellID = "recentlyPurchasedClipperPassCollectionViewCellID"
    let recentlyPurchasedClipperPassCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collection.backgroundColor = UIColor.white
        collection.isScrollEnabled = true
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    let agencies = Agency.allCases.filter{$0.rawValue != "0"}
    let recentAgencies = UserManager.shared.getValidPasses().filterDuplicate{$0.validOnAgency}

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Add Pass"
        navigationItem.largeTitleDisplayMode = .never

        clipperPassCollectionView.delegate = self
        clipperPassCollectionView.dataSource = self
        clipperPassCollectionView.register(ClipperPassCollectionViewCell.self, forCellWithReuseIdentifier: clipperPassCollectionViewCellID)

        recentlyPurchasedClipperPassCollectionView.delegate = self
        recentlyPurchasedClipperPassCollectionView.dataSource = self
        recentlyPurchasedClipperPassCollectionView.register(ClipperPassCollectionViewCell.self, forCellWithReuseIdentifier: recentlyPurchasedClipperPassCollectionViewCellID)
        
        setupView()
    }

    func setupView() {
        view.addSubview(agenciesLbl)
        agenciesLbl.text = "Agencies"
        agenciesLbl.textColor = UIColor.black
        agenciesLbl.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        
        view.addSubview(clipperPassCollectionView)
        clipperPassCollectionView.snp.makeConstraints { (make) -> Void in
            make.left.right.equalToSuperview().inset(10)
            make.top.equalTo(agenciesLbl.snp.bottom).offset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        if UserManager.shared.getValidPasses().count > 0 {
            view.addSubview(recentlyPurchasedLbl)
            recentlyPurchasedLbl.text = "Recently Purchased"
            recentlyPurchasedLbl.textColor = UIColor.black
            recentlyPurchasedLbl.font = UIFont.systemFont(ofSize: 26, weight: .bold)
            recentlyPurchasedLbl.snp.makeConstraints { (make) -> Void in
                make.leading.equalToSuperview().offset(20)
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            }

            view.addSubview(recentlyPurchasedClipperPassCollectionView)
            recentlyPurchasedClipperPassCollectionView.snp.makeConstraints { (make) -> Void in
                make.leading.equalToSuperview().offset(0)
                make.trailing.equalToSuperview().offset(0)
                make.top.equalTo(recentlyPurchasedLbl.snp.bottom).offset(10)
                make.height.equalTo(140)
            }

            agenciesLbl.snp.makeConstraints { (make) -> Void in
                make.leading.equalToSuperview().offset(20)
                make.top.equalTo(recentlyPurchasedClipperPassCollectionView.snp.bottom).offset(15)
            }
        } else {
            agenciesLbl.snp.makeConstraints { (make) -> Void in
                make.leading.equalToSuperview().offset(20)
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(15)
            }

        } 
        
    }
    
}
