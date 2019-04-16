//
//  ClipperPassViewController.swift
//  BayPass
//
//  Created by Zhe Li on 4/15/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import SnapKit
import UIKit

class ClipperPassViewController: UIViewController{
    
    let agenciesLbl = UILabel()
    
    let clipperPassCollectionViewCellID = "clipperPassCollectionViewCellID"
    let clipperPassCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        //layout.sectionInset = UIEdgeInsets(top: 9, left: 10, bottom: 9, right: 10)
        //layout.minimumLineSpacing = 18
        //layout.itemSize = CGSize(width: 160, height: 85)
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        //let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        layout.scrollDirection = .vertical
        collection.backgroundColor = UIColor.white
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isScrollEnabled = true
        collection.showsVerticalScrollIndicator = false
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
        
        setupView()
        

    }
    
    func setupView(){
        
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
            make.top.equalTo(agenciesLbl.snp.bottom).offset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
        }
        
    }
    
}
