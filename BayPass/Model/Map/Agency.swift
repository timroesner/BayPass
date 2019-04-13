//
//  Agency.swift
//  BayPass
//
//  Created by Ayesha Khan on 10/20/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//
import UIKit

enum Agency: String {
    case ACTransit = "AC " // AC Transit
    case VTA = "SC" // VTA
    case BART = "BAR" // Bart
    case CalTrain = "CT" // Caltrain
    case GoldenGateTransit = "GGT"
    case Muni = "SF" // San Francisco Municipal Transportation Agency
    case UnionCity = "UC" // Union City Transit
    case ACE = "99" // Altamont Corridor Express
    case SolTrans = "247" // SolTrans
    case SamTrans = "sam" // SamsTrans
    case zero = "0" // Debugging

    var stringValue: String {
        switch self {
        case .ACTransit:
            return "AC Transit"
        case .VTA:
            return "VTA"
        case .BART:
            return "BART"
        case .CalTrain:
            return "CalTrain"
        case .GoldenGateTransit:
            return "Golden Gate Transit"
        case .Muni:
            return "Muni"
        case .UnionCity:
            return "Union City Transit"
        case .ACE:
            return "ACE"
        case .SamTrans:
            return "SamsTrans"
        case .SolTrans:
            return "SolsTrans"
        default:
            return ""
        }
    }

    func getIcon() -> UIImage {
        switch self {
        case .ACE:
            return #imageLiteral(resourceName: "CalTrain")
        case .ACTransit:
            return #imageLiteral(resourceName: "Bus")
        case .BART:
            return #imageLiteral(resourceName: "BART")
        case .CalTrain:
            return #imageLiteral(resourceName: "CalTrain")
        case .GoldenGateTransit:
            return #imageLiteral(resourceName: "Bus")
        case .Muni:
            return #imageLiteral(resourceName: "Bus")
        case .UnionCity:
            return #imageLiteral(resourceName: "Bus")
        case .SamTrans:
            return #imageLiteral(resourceName: "Bus")
        case .SolTrans:
            return #imageLiteral(resourceName: "Bus")
        default:
            return #imageLiteral(resourceName: "CalTrain")
        }
    }
}
