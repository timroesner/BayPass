//
//  TVCOverlay.swift
//  BayPass
//
//  Created by Tim Roesner on 4/20/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import Foundation
import OverlayContainer

extension TicketViewController: OverlayContainerViewControllerDelegate {
    func numberOfNotches(in _: OverlayContainerViewController) -> Int {
        return notchPercentages.count
    }
    
    func overlayContainerViewController(_: OverlayContainerViewController, heightForNotchAt index: Int, availableSpace: CGFloat) -> CGFloat {
        return availableSpace * notchPercentages[index]
    }
}
