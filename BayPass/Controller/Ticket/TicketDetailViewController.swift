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
    var session: NFCNDEFReaderSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.layer.cornerRadius = 21
        
        // present ticket
        agency = ticket?.validOnAgency ?? Agency.zero
        let newTicketView = TicketView(agency: agency, icon: agency.getIcon(), cornerRadius: 12)
        setUpTicketView(newTicketView: newTicketView)
        let count = ticket?.count
        setUpLabels(count: count!)
        
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
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(25)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(newTicketView.snp.width).multipliedBy(0.6)
        }
        newTicketView.layoutIfNeeded()
        stackedViews.append(newTicketView)
    }
    
    func setUpLabels(count: Int) {
        
        if count > 0 {
            view.addSubview(countLb)
            countLb.text = "Count Remaining"
            countLb.textColor = UIColor.gray
            countLb.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
            countLb.snp.makeConstraints { (make) -> Void in
                make.centerX.equalTo((stackedViews.last?.snp.centerX)!)
                make.top.equalTo((stackedViews.last?.snp.bottom)!).offset(50)
            }
            stackedViews.append(countLb)

            view.addSubview(countInfoLb)
            countInfoLb.text = String(count)
            countInfoLb.textColor = UIColor.black
            countInfoLb.font = UIFont.systemFont(ofSize: 26, weight: .bold)
            countInfoLb.snp.makeConstraints { (make) -> Void in
                make.centerX.equalTo((stackedViews.last?.snp.centerX)!)
                make.top.equalTo((stackedViews.last?.snp.bottom)!).offset(10)
            }
            stackedViews.append(countInfoLb)

        }

        // not sure what happen here
        else {
            view.addSubview(durationLb)
            durationLb.text = "Time Remaining"
            durationLb.textColor = UIColor.gray
            durationLb.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
            durationLb.snp.makeConstraints { (make) -> Void in
                make.centerX.equalTo((stackedViews.last?.snp.centerX)!)
                make.top.equalTo((stackedViews.last?.snp.bottom)!).offset(50)
            }
            stackedViews.append(durationLb)
            
            view.addSubview(durationInfoLb)
            let d = Int(ticket?.duration?.duration ?? 0.0)
            durationInfoLb.text = d.durationToStringShort()
            durationInfoLb.textColor = UIColor.black
            durationInfoLb.font = UIFont.systemFont(ofSize: 26, weight: .bold)
            durationInfoLb.snp.makeConstraints { (make) -> Void in
                make.centerX.equalTo((stackedViews.last?.snp.centerX)!)
                make.top.equalTo((stackedViews.last?.snp.bottom)!).offset(10)
            }
            stackedViews.append(durationInfoLb)
            
        }
        view.addSubview(typeLb)
        typeLb.text = "Type"
        typeLb.textColor = UIColor.gray
        typeLb.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        typeLb.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo((stackedViews.last?.snp.centerX)!)
            make.top.equalTo((stackedViews.last?.snp.bottom)!).offset(50)
        }
        stackedViews.append(typeLb)
        
        view.addSubview(typeInfoLb)
        typeInfoLb.text = ticket?.name
        typeInfoLb.textColor = UIColor.black
        typeInfoLb.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        typeInfoLb.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo((stackedViews.last?.snp.centerX)!)
            make.top.equalTo((stackedViews.last?.snp.bottom)!).offset(10)
        }
        stackedViews.append(typeInfoLb)
    }
    
    @objc func scanTicket() {
        session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        session?.alertMessage = "Hold your iPhone near the card reader."
        session?.begin()
    }
}

extension TicketDetailViewController: NFCNDEFReaderSessionDelegate {
    func readerSession(_: NFCNDEFReaderSession, didInvalidateWithError _: Error) {
        print("Error")
    }
    
    func readerSession(_: NFCNDEFReaderSession, didDetectNDEFs _: [NFCNDEFMessage]) {
        print("Success")
    }
}
