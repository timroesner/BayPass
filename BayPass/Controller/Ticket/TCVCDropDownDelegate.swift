//
//  TCVCDropDownDelegate.swift
//  BayPass
//
//  Created by Tim Roesner on 4/14/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import UIKit

extension TicketCheckoutViewController: DropDownDelegate {
    func didChangeSelectedItem(_ sender: DropDownMenu) {
        if sender.titleLbl.text != "PAYMENT METHOD" {
            switch agency {
            case .BART:
                updateBARTTicketPrice()
            default:
                break
            }
        }
    }

    func updateBARTTicketPrice() {
        guard let type = stackedViews[safe: 1] as? DropDownMenu,
            let fromDropDown = stackedViews[safe: 2] as? DropDownMenu,
            let toDropDown = stackedViews[safe: 3] as? DropDownMenu
        else { return }

        TicketManager.shared.getBARTPrice(from: fromDropDown.getSelectedItem(), to: toDropDown.getSelectedItem()) { newPrice in
            let calculatedPrice = type.getSelectedItem() == "Roundtrip" ? newPrice * 2 : newPrice
            self.currentTicketPrice = calculatedPrice
            self.payButton?.setTitle(String(format: "Pay $%.2f", calculatedPrice), for: .normal)
        }
    }
}
