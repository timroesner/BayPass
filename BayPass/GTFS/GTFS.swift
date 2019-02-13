//
//  GTFS.swift
//  BayPass
//
//  Created by Ayesha Khan on 2/11/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import Alamofire
import Foundation

public enum GTFS {
    case gtfsoperators
    case stopFromStations
}

extension GTFS: Endpoint {
    var base: String {
        return "https://api.511.org"
    }

    var path: String {
        switch self {
        case .gtfsoperators: return "/transit/gtfsoperators"
        case .stopFromStations: return "/transit/stops"
        }
    }
}
