//
//  Agency.swift
//  BayPass
//
//  Created by Ayesha Khan on 10/20/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

import UIKit

enum Agency: String {
    case ACTransit = "AC" // AC Transit
    case VTA = "SC" // VTA
    case BART = "BAR" // Bart
    case CalTrain = "CT" // Caltrain
    case Muni = "SF" // San Francisco Municipal Transportation Agency
    case UnionCity = "UC" // Union City Transit
    case ACE = "99" // Altamont Corridor Express
    case SolTrans = "247" // SolsTrans

    func getIcon() -> UIImage {
        switch self {
        case .BART:
            return #imageLiteral(resourceName: "BART")
        case .CalTrain:
            return #imageLiteral(resourceName: "CalTrain")
        default:
            return #imageLiteral(resourceName: "CalTrain")
        }
    }
}
