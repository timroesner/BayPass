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
    
    var ticket: Ticket?
    var pass: Pass?
    var ticketView: TicketView
    var session: NFCNDEFReaderSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.layer.cornerRadius = 21
    }
    
    init(ticket: Ticket) {
        ticketView = TicketView(agency: ticket.validOnAgency, icon: ticket.validOnAgency.getIcon(), cornerRadius: 12)
        self.ticket = ticket
        super.init(nibName: nil, bundle: nil)
        setUpTicketView()
        setUpLabels()
        setUpScanButton(color: ticket.validOnAgency.getColor())
    }
    
    init(pass: Pass) {
        ticketView = TicketView(agency: pass.validOnAgency, icon: pass.validOnAgency.getIcon(), cornerRadius: 12)
        self.pass = pass
        super.init(nibName: nil, bundle: nil)
        setUpTicketView()
        setUpLabels()
    }
    
    func setUpTicketView() {
        let moveIndicator = MoveIndicator()
        view.addSubview(moveIndicator)
        moveIndicator.setConstraints()
        
        view.addSubview(ticketView)
        ticketView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(moveIndicator).offset(25)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(ticketView.snp.width).multipliedBy(0.6)
        }
        ticketView.layoutIfNeeded()
    }
    
    func setUpLabels() {
        
        let infoTitleLabel = UILabel()
        infoTitleLabel.textColor = UIColor.gray
        infoTitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        
        let infoLabel = UILabel()
        infoLabel.textColor = UIColor.black
        infoLabel.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        
        if (ticket?.count ?? 0) > 0 {
            infoTitleLabel.text = "Count Remaining"
            infoLabel.text = String(ticket?.count ?? 0)
        } else {
            infoTitleLabel.text = "Time Remaining"
            let d = Int(ticket?.duration?.duration ?? pass?.duration.duration ?? 0.0)
            infoLabel.text = d.durationToStringShort()
        }
        
        view.addSubview(infoTitleLabel)
        infoTitleLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(ticketView.snp.centerX)
            make.top.equalTo(ticketView.snp.bottom).offset(50)
        }
        
        view.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(infoTitleLabel.snp.centerX)
            make.top.equalTo(infoTitleLabel.snp.bottom).offset(10)
        }
        
        let border = UILabel()
        border.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1.00)
        view.addSubview(border)
        border.snp.makeConstraints { make in
            make.height.equalTo(1.5)
            make.left.right.equalToSuperview().inset(54)
            make.top.equalTo(infoLabel.snp.bottom).offset(40)
        }
        
        let typeLb = UILabel()
        view.addSubview(typeLb)
        typeLb.text = "Type"
        typeLb.textColor = UIColor.gray
        typeLb.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        typeLb.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(infoLabel.snp.centerX)
            make.top.equalTo(border.snp.bottom).offset(40)
        }
        
        let typeInfoLb = UILabel()
        view.addSubview(typeInfoLb)
        typeInfoLb.text = ticket?.name ?? pass?.name
        typeInfoLb.textColor = UIColor.black
        typeInfoLb.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        typeInfoLb.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(typeLb.snp.centerX)
            make.top.equalTo(typeLb.snp.bottom).offset(10)
        }
    }
    
    func setUpScanButton(color: UIColor) {
        let scanTicketButton = BayPassButton(title: "Scan Ticket", color: color)
        scanTicketButton.addTarget(self, action: #selector(scanTicket), for: .touchUpInside)
        view.addSubview(scanTicketButton)
        scanTicketButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
        }
    }
    
    @objc func scanTicket() {
        session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        session?.alertMessage = "Hold your iPhone near the card reader."
        session?.begin()
    }
    
    required init?(coder aDecoder: NSCoder) {
        print("init(coder:) has not been implemented for TicketDetailVC")
        return nil
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
