//
//  MVCOverlay.swift
//  BayPass
//
//  Created by Tim Roesner on 3/1/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import OverlayContainer
import UIKit

extension MapViewController: OverlayContainerViewControllerDelegate {
    func numberOfNotches(in _: OverlayContainerViewController) -> Int {
        return notchPercentages.count
    }

    func overlayContainerViewController(_: OverlayContainerViewController, heightForNotchAt index: Int, availableSpace: CGFloat) -> CGFloat {
        return availableSpace * notchPercentages[index]
    }

    func overlayContainerViewController(_: OverlayContainerViewController, didEndDraggingOverlay _: UIViewController, transitionCoordinator: OverlayContainerTransitionCoordinator) {
        if transitionCoordinator.targetNotchIndex == 0 {
            searchVC.searchBar.resignFirstResponder()
            searchVC.searchBar.setShowsCancelButton(false, animated: true)
        }
    }

    func setupSearchView() {
        searchVC.resetSearch()
        bottomSheet.drivingScrollView = searchVC.tableView
        notchPercentages = [0.20, 0.93]
        bottomSheet.viewControllers = [searchVC]
    }
}
