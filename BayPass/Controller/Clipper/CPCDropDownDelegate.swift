//
//  CPCDropDownDelegate.swift
//  BayPass
//
//  Created by Tim Roesner on 4/19/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import Foundation

extension ClipperPassCheckoutViewController: DropDownDelegate {
    func didChangeSelectedItem(_ sender: DropDownMenu) {
        if sender.titleLbl.text != "PAYMENT METHOD" {
            switch agency {
            case .BART:
                updateBARTTicketPrice()
            case .CalTrain:
                updateCalTrainTicketPrice()
            default:
                updateTicketPrice()
            }
        }
    }
    
    func updateBARTTicketPrice() {
        guard let typeDropDown = stackedViews[safe: 1] as? DropDownMenu,
            let fromDropDown = stackedViews[safe: 2] as? DropDownMenu,
            let toDropDown = stackedViews[safe: 3] as? DropDownMenu
            else { return }
        
        TicketManager.shared.getBARTPrice(from: fromDropDown.getSelectedItem(), to: toDropDown.getSelectedItem()) { newPrice in
            let calculatedPrice = typeDropDown.getSelectedItem() == "Roundtrip" ? newPrice * 2 : newPrice
            self.currentPassPrice = calculatedPrice
            self.payButton?.setTitle(String(format: "Pay $%.2f", calculatedPrice), for: .normal)
        }
    }
    
    func updateCalTrainTicketPrice() {
        guard let typeDropDown = stackedViews[safe: 1] as? DropDownMenu,
            let fromDropDown = stackedViews[safe: 2] as? DropDownMenu,
            let toDropDown = stackedViews[safe: 3] as? DropDownMenu
            else { return }
        
        if let price = TicketManager.shared.getCalTrainPrice(ticketType: typeDropDown.getSelectedItem(), from: fromDropDown.getSelectedItem(), to: toDropDown.getSelectedItem()) {
            self.currentPassPrice = price
            self.payButton?.setTitle(String(format: "Pay $%.2f", price), for: .normal)
        } else {
            self.currentPassPrice = 0.0
            self.payButton?.setTitle("Invalid Input", for: .normal)
        }
    }
    
    func updateTicketPrice() {
        guard let typeDropDown = stackedViews[safe: 1] as? DropDownMenu else { return }
        let subTypeDropDown = stackedViews[safe: 2] as? DropDownMenu
        let subType = subTypeDropDown?.titleLbl.text != "SUB TYPE" ? nil : subTypeDropDown?.getSelectedItem()
        
        if let price = TicketManager.shared.getTicketPrice(agency: agency, ticketType: typeDropDown.getSelectedItem(), subType: subType) {
            self.currentPassPrice = price
            self.payButton?.setTitle(String(format: "Pay $%.2f", price), for: .normal)
        } else {
            self.currentPassPrice = 0.0
            self.payButton?.setTitle("Invalid Input", for: .normal)
        }
    }
}
