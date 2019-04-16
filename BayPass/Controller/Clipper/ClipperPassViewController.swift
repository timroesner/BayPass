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
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        collection.backgroundColor = UIColor.white
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isScrollEnabled = true
        collection.showsVerticalScrollIndicator = false
        return collection
    }()

    let recentlyPurchasedClipperPassCollectionViewCellID = "recentlyPurchasedClipperPassCollectionViewCellID"
    let recentlyPurchasedClipperPassCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collection.backgroundColor = UIColor.white
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isScrollEnabled = true
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()

    let agencies = Agency.allCases

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Add Pass"
        navigationController?.navigationBar.prefersLargeTitles = false

        clipperPassCollectionView.delegate = self
        clipperPassCollectionView.dataSource = self
        clipperPassCollectionView.register(ClipperPassCollectionViewCell.self, forCellWithReuseIdentifier: clipperPassCollectionViewCellID)

        recentlyPurchasedClipperPassCollectionView.delegate = self
        recentlyPurchasedClipperPassCollectionView.dataSource = self
        recentlyPurchasedClipperPassCollectionView.register(ClipperPassCollectionViewCell.self, forCellWithReuseIdentifier: recentlyPurchasedClipperPassCollectionViewCellID)

        // MARK: temporary data for testing "Recently Purchased"

        let BARTPass = Pass(name: Agency.BART.stringValue,
                            duration: DateInterval(start: Date(timeIntervalSinceNow: -470_482.0), end: Date(timeIntervalSinceNow: 470_482.0)),
                            price: 0.0,
                            validOnAgency: Agency.BART)
        let CalTrainPass = Pass(name: Agency.CalTrain.stringValue,
                                duration: DateInterval(start: Date(timeIntervalSinceNow: -470_482.0), end: Date(timeIntervalSinceNow: 470_482.0)),
                                price: 0.0,
                                validOnAgency: Agency.CalTrain)
        UserManager.shared.addPass(pass: BARTPass)
        UserManager.shared.addPass(pass: CalTrainPass)

        setupView()
    }

    func setupView() {
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

            view.addSubview(agenciesLbl)
            agenciesLbl.text = "Agencies"
            agenciesLbl.textColor = UIColor.black
            agenciesLbl.font = UIFont.systemFont(ofSize: 24, weight: .bold)
            agenciesLbl.snp.makeConstraints { (make) -> Void in
                make.leading.equalToSuperview().offset(20)
                make.top.equalTo(recentlyPurchasedClipperPassCollectionView.snp.bottom).offset(20)
            }

            view.addSubview(clipperPassCollectionView)
            clipperPassCollectionView.snp.makeConstraints { (make) -> Void in
                make.leading.equalToSuperview().offset(10)
                make.trailing.equalToSuperview().inset(10)
                make.top.equalTo(agenciesLbl.snp.bottom).offset(10)
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            }

        } else {
            view.addSubview(agenciesLbl)
            agenciesLbl.text = "Agencies"
            agenciesLbl.textColor = UIColor.black
            agenciesLbl.font = UIFont.systemFont(ofSize: 24, weight: .bold)
            agenciesLbl.snp.makeConstraints { (make) -> Void in
                make.leading.equalToSuperview().offset(20)
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            }

            view.addSubview(clipperPassCollectionView)
            clipperPassCollectionView.snp.makeConstraints { (make) -> Void in
                make.leading.equalToSuperview().offset(10)
                make.trailing.equalToSuperview().inset(10)
                make.top.equalTo(agenciesLbl.snp.bottom).offset(10)
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            }
        }
    }
}
