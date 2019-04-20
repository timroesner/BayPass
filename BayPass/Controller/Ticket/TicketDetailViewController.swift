//
//  TicketDetailViewController.swift
//  BayPass
//
//  Created by 凌脩羽 on 4/19/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import OverlayContainer
import UIKit
import CoreNFC

class TicketDetailViewController: UIViewController {
    let bottomSheet = OverlayContainerViewController(style: .rigid)
    var ticket : Ticket?
    var agency = Agency.zero
    private var stackedViews = [UIView]()
    let countLb = UILabel()
    let countInfoLb = UILabel()
    let durationLb = UILabel()
    let durationInfoLb = UILabel()
    let typeLb = UILabel()
    let typeInfoLb = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // OverlayContainer here
//        bottomSheet.delegate = self as? OverlayContainerViewControllerDelegate
//        addChild(bottomSheet, in: view)
//        bottomSheet.moveOverlay(toNotchAt: 0, animated: true)
        // Do any additional setup after loading the view.
        
        // present ticket
        agency = ticket?.validOnAgency ?? Agency.zero
        setUpTicketView(newTicketView: TicketView(agency: agency, icon: agency.getIcon(), cornerRadius: 12))
        setUpLabels()
        
        // scan ticket button at bottom of the view
        let color = agency.getColor()
        let scanTicketButton = BayPassButton(title: "Scan Ticket", color: color)
        scanTicketButton.addTarget(self, action: #selector(scanTicket), for: .touchUpInside)
        view.addSubview(scanTicketButton)
        scanTicketButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
        }
    }
    
    func setUpTicketView(newTicketView: TicketView) {
        view.addSubview(newTicketView)
        newTicketView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(25).priority(.low)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(newTicketView.snp.width).multipliedBy(0.6)
        }
        newTicketView.layoutIfNeeded()
        stackedViews.append(newTicketView)
    }
    
    func setUpLabels() {
        view.addSubview(typeLb)
        typeLb.text = "Type"
        typeLb.textColor = UIColor.gray
        typeLb.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        typeLb.snp.makeConstraints { (make) -> Void in
            make.leading.equalToSuperview().offset(30)
            make.top.equalTo((stackedViews.last?.snp.bottom)!).offset(30)
        }
    }
    
    @objc func scanTicket() {
        print("scan ticket button pressed")
    }
}
