//
//  ClipperOnBoarding.swift
//  BayPass
//
//  Created by Tim Roesner on 3/28/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import UIKit

extension ClipperViewController {
    func setupOnBoarding() {
        for view in view.subviews {
            view.removeFromSuperview()
        }
        let emptyClipperView = UIView()
        emptyClipperView.layer.backgroundColor = UIColor(hex: 0xF3F2F4).cgColor
        emptyClipperView.layer.cornerRadius = 14
        emptyClipperView.layer.borderColor = UIColor(hex: 0xD3D3D4).cgColor
        emptyClipperView.layer.borderWidth = 1.0
        view.addSubview(emptyClipperView)
        emptyClipperView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(28)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(emptyClipperView.snp.width).multipliedBy(0.6)
        }
        let clipperLogo = UIImageView()
        clipperLogo.contentMode = .scaleAspectFit
        clipperLogo.image = #imageLiteral(resourceName: "ClipperLogoVertical")
        emptyClipperView.addSubview(clipperLogo)
        clipperLogo.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(30)
            make.left.equalToSuperview().offset(36)
        }

        let signInButton = BayPassButton(title: "Log into MyClipper", color: UIColor().clipperBlue)
        signInButton.addTarget(self, action: #selector(signInMyClipper), for: .touchUpInside)
        view.addSubview(signInButton)
        signInButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }

        let label = UILabel()
        label.text = "OR"
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = UIColor(hex: 0x9B9B9B)
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(signInButton.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }

        let createVirtualButton = BayPassButton(title: "Create new Virtual Card", color: UIColor().clipperBlue)
        createVirtualButton.addTarget(self, action: #selector(createVirtualClipper), for: .touchUpInside)
        view.addSubview(createVirtualButton)
        createVirtualButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
            make.top.equalTo(label.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }

    @objc func signInMyClipper() {
        navigationController?.pushViewController(SignInViewController(), animated: true)
    }

    @objc func createVirtualClipper() {
        let newCardNumber = Int.random(in: 1_111_111_111 ... 9_999_999_999)
        let newCard = ClipperCard(number: newCardNumber, cashValue: 0.0, passes: [])
        UserManager.shared.setClipperCard(card: newCard)
        setupRegularView()
    }
}
