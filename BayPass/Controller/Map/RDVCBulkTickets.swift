//
//  RDVCBulkTicket.swift
//  BayPass
//
//  Created by Tim Roesner on 5/1/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import Stripe
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
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(routeOverView!.snp.bottom).offset(16)
            make.left.equalToSuperview().inset(20)
        }

        let routeHasMultipleTransit = (route?.segments.filter { $0.travelMode == .transit }.count ?? 0) > 1
        var buttonColor = #colorLiteral(red: 0.6504354477, green: 0.4037398994, blue: 0.844121635, alpha: 1)
        if !routeHasMultipleTransit {
            buttonColor = route?.segments.filter { $0.travelMode == .transit }.first?.line?.color ?? .blue
        }
        let priceString = " " + (route?.getPrice() ?? "")
        let payButton = BayPassButton(title: "Pay" + priceString, color: buttonColor)
        payButton.addTarget(self, action: #selector(pay), for: .touchUpInside)
        view.addSubview(payButton)
        payButton.snp.makeConstraints { make in
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
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().inset(20)
            make.right.equalToSuperview()
            make.bottom.equalTo(payButton.snp.top).offset(2)
        }

        let closeButton = BayPassButton(title: "X", color: .lightGray)
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.height.width.equalTo(50)
            make.right.equalToSuperview().inset(20)
            make.left.equalTo(payButton.snp.right).offset(12)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(16)
        }
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return route?.segments.filter { $0.price > 0.0 }.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let segement = route?.segments.filter { $0.price > 0.0 }[safe: indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ticketCell", for: indexPath) as! BulkTicketTableViewCell
        cell.setup(with: segement)
        return cell
    }

    @objc func pay() {
        var items = [(name: String, amount: Double)]()
        for segment in (route?.segments.filter { $0.price > 0.0 }) ?? [] {
            items.append((name: "Single Ride - " + (segment.line?.agency.stringValue ?? ""), amount: segment.price))
        }
        items.append((name: "BayPass", amount: route?.getPrice() ?? 0.0))
        checkoutWithApplePay(items: items, delegate: self)
    }

    @objc func close() {
        for view in view.subviews {
            if !(view is RouteOverView) {
                view.removeFromSuperview()
            }
        }

        view.addSubview(buyButton)
        buyButton.snp.makeConstraints { make in
            make.top.equalTo(routeOverView!.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }

        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(buyButton.snp.bottom).offset(16)
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        parentSheet?.drivingScrollView = scrollView
    }
}

extension RouteDetailsViewController: PKPaymentAuthorizationViewControllerDelegate {
    func paymentAuthorizationViewController(_: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, completion: @escaping (PKPaymentAuthorizationStatus) -> Void) {
        STPAPIClient.shared().createToken(with: payment) { (token: STPToken?, error: Error?) in
            guard let token = token, error == nil else {
                completion(.failure)
                return
            }

            // Here we could call our backend if we actually would submit the payment
            print(token)
            completion(.success)
            self.purchaseSucceded = true
            for segment in (self.route?.segments.filter { $0.price > 0.0 }) ?? [] {
                let newTicket = Ticket(name: "Single Ride", count: 1, price: segment.price, validOnAgency: segment.line?.agency ?? .zero)
                UserManager.shared.addPurchased(ticket: newTicket)
            }
        }
    }

    func paymentAuthorizationViewControllerDidFinish(_: PKPaymentAuthorizationViewController) {
        dismiss(animated: true, completion: {
            if self.purchaseSucceded {
                self.tabBarController?.selectedIndex = 1
                self.close()
            }
        })
    }
}
