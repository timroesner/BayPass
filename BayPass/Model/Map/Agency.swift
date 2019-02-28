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
    var abbrv: String
    var id: String

    init(name: String, abbrv: String, id: String) {
        self.name = name
        self.abbrv = abbrv
        self.id = id
    }
}
