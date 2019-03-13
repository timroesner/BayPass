//
//  TabViewController.swift
//  BayPass
//
//  Created by Tim Roesner on 10/18/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let mapVC = MapViewController()
        mapVC.tabBarItem = UITabBarItem(title: "Map".localized(), image: #imageLiteral(resourceName: "MapIcon"), tag: 0)

        let ticketVC = TicketViewController()
        ticketVC.tabBarItem = UITabBarItem(title: "Ticket".localized(), image: #imageLiteral(resourceName: "TicketIcon"), tag: 0)
        let ticketNVC = UINavigationController(rootViewController: ticketVC)

        let clipperVC = ClipperViewController()
        clipperVC.tabBarItem = UITabBarItem(title: "Clipper".localized(), image: #imageLiteral(resourceName: "ClipperIcon"), tag: 0)
        let clipperNVC = UINavigationController(rootViewController: clipperVC)

        let viewControllerList = [mapVC, ticketNVC, clipperNVC]
        viewControllers = viewControllerList
    }
}
