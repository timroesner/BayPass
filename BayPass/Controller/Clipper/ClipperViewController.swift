//
//  ClipperViewController.swift
//  BayPass
//
//  Created by Tim Roesner on 10/18/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

import CoreNFC
import SnapKit
import UIKit
import OverlayContainer

class ClipperViewController: UIViewController {
    var collectionView: UICollectionView?
    let cellIdentifier = "clipperPassCell"
    let bottomSheet = OverlayContainerViewController(style: .rigid)
    var notchPercentages: [CGFloat] = [0.0, 0.93]
    var session: NFCNDEFReaderSession?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = "Clipper"
        
        bottomSheet.delegate = self

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView?.backgroundColor = .white
        collectionView?.register(ClipperPassCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView?.delegate = self
        collectionView?.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupRegularView()
        collectionView?.reloadData()
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    func setupRegularView() {
        if let myClipperCard = UserManager.shared.getClipperCard() {
            for view in view.subviews {
                view.removeFromSuperview()
            }
            let clipperView = ClipperView(cardNumber: myClipperCard.number, cashValue: myClipperCard.cashValue)
            clipperView.isUserInteractionEnabled = true
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(scanCard))
            clipperView.addGestureRecognizer(tapRecognizer)
            view.addSubview(clipperView)
            clipperView.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
                make.left.right.equalToSuperview().inset(20)
                make.height.equalTo(clipperView.snp.width).multipliedBy(0.6)
            }

            let label = UILabel()
            label.text = "Active Passes"
            label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
            label.textColor = .black
            view.addSubview(label)
            label.snp.makeConstraints { make in
                make.top.equalTo(clipperView.snp.bottom).offset(25)
                make.left.equalTo(clipperView.snp.left)
            }

            view.addSubview(collectionView!)
            collectionView?.snp.makeConstraints { make in
                make.top.equalTo(label.snp.bottom).offset(4)
                make.left.equalTo(label.snp.left)
                make.right.equalToSuperview()
                make.height.equalTo(125).priority(.low)
            }

            let addCashButton = BayPassButton(title: "Add Cash Value", color: UIColor().clipperBlue)
            addCashButton.addTarget(self, action: #selector(addCash), for: .touchUpInside)
            view.addSubview(addCashButton)
            addCashButton.snp.makeConstraints { make in
                make.top.greaterThanOrEqualTo(collectionView!.snp.bottom).offset(20)
                make.left.right.equalToSuperview().inset(20)
                make.height.equalTo(50)
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
            }
        } else {
            setupOnBoarding()
        }
    }

    @objc func addCash() {
        navigationController?.pushViewController(ClipperAddCashViewController(), animated: true)
    }

    @objc func scanCard() {
        session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        session?.alertMessage = "Hold your iPhone near the Clipper card reader."
        session?.begin()
    }
}

extension ClipperViewController: NFCNDEFReaderSessionDelegate {
    func readerSession(_: NFCNDEFReaderSession, didInvalidateWithError _: Error) {
        print("Error")
    }

    func readerSession(_: NFCNDEFReaderSession, didDetectNDEFs _: [NFCNDEFMessage]) {
        print("Success")
    }
}
