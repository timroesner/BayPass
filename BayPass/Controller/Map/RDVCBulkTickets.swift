//
//  RDVCBulkTicket.swift
//  BayPass
//
//  Created by Tim Roesner on 5/1/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import UIKit

extension RouteDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupBulkTicketsView() {
        for view in view.subviews {
            if !(view is RouteOverView) {
                view.removeFromSuperview()
            }
        }
        
        let titleLabel = UILabel()
        titleLabel.text = "Summary"
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(routeOverView!.snp.bottom).offset(16)
            make.left.equalToSuperview().inset(20)
        }
        
        let priceString = " "+(route?.getPrice() ?? "")
        let payButton = BayPassButton(title: "Pay"+priceString, color: #colorLiteral(red: 0.6504354477, green: 0.4037398994, blue: 0.844121635, alpha: 1))
        payButton.addTarget(self, action: #selector(pay), for: .touchUpInside)
        view.addSubview(payButton)
        payButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(16)
            make.height.equalTo(50)
            make.left.equalToSuperview().inset(16)
        }
        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 76.0
        tableView.backgroundColor = UIColor(hex: 0xF8F8F8)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.register(BulkTicketTableViewCell.self, forCellReuseIdentifier: "ticketCell")
        parentSheet?.drivingScrollView = tableView
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().inset(20)
            make.right.equalToSuperview()
            make.bottom.equalTo(payButton.snp.top).offset(2)
        }
        
        let closeButton = BayPassButton(title: "X", color: .lightGray)
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints { (make) in
            make.height.width.equalTo(50)
            make.right.equalToSuperview().inset(20)
            make.left.equalTo(payButton.snp.right).offset(12)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(16)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return route?.segments.filter{$0.price > 0.0}.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let segement = route?.segments.filter{$0.price > 0.0}[safe: indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ticketCell", for: indexPath) as! BulkTicketTableViewCell
        cell.setup(with: segement)
        return cell
    }
    
    @objc func pay() {
        print("Pay")
    }
    
    @objc func close() {
        for view in view.subviews {
            if !(view is RouteOverView) {
                view.removeFromSuperview()
            }
        }
        
        view.addSubview(buyButton)
        buyButton.snp.makeConstraints { (make) in
            make.top.equalTo(routeOverView!.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(buyButton.snp.bottom).offset(16)
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        parentSheet?.drivingScrollView = scrollView
    }
}


