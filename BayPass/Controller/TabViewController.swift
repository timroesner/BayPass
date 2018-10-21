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
        mapVC.tabBarItem = UITabBarItem(title: "Map", image: #imageLiteral(resourceName: "MapIcon"), tag: 0)

        let ticketVC = TicketViewController()
        ticketVC.tabBarItem = UITabBarItem(title: "Ticket", image: #imageLiteral(resourceName: "TicketIcon"), tag: 0)

        let clipperVC = ClipperViewController()
        clipperVC.tabBarItem = UITabBarItem(title: "Clipper", image: #imageLiteral(resourceName: "ClipperIcon"), tag: 0)

        let viewControllerList = [mapVC, ticketVC, clipperVC]
        viewControllers = viewControllerList
    }
}

extension UIViewController {
    func addLabel(title: String) {
        let label = UILabel()
        label.text = title
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
