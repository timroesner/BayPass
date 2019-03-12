//
//  Agency.swift
//  BayPass
//
//  Created by Ayesha Khan on 10/20/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

import UIKit

struct Agency {
    var name: String
    var icon: UIImage
    var routes: [Line]

    init(name: String, routes: [Line], icon: UIImage) {
        self.name = name
        self.routes = routes
        self.icon = icon
    }

    func getRoutes() -> [Line] {
        return routes
    }
}
