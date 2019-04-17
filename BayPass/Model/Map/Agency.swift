//
//  Agency.swift
//  BayPass
//
//  Created by Ayesha Khan on 10/20/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//
import UIKit

enum Agency: String, Codable, CaseIterable {
    case VTA = "SC" // VTA
    case BART = "BAR" // Bart
    case CalTrain = "CT" // Caltrain
    case Muni = "SF" // San Francisco Municipal Transportation Agency
    case UnionCity = "UC" // Union City Transit
    case SamTrans = "sam" // SamTrans
    case GoldenGateTransit = "GGT"
    case ACTransit = "AC " // AC Transit
    case ACE = "99" // Altamont Corridor Express
    case SolTrans = "247" // SolTrans
    case zero = "0" // Debugging

    var stringValue: String {
        switch self {
        case .VTA:
            return "VTA"
        case .BART:
            return "BART"
        case .CalTrain:
            return "CalTrain"
        case .Muni:
            return "Muni"
        case .GoldenGateTransit:
            return "Golden Gate Transit"
        case .ACTransit:
            return "AC Transit"
        case .UnionCity:
            return "Union City Transit"
        case .ACE:
            return "ACE"
        case .SamTrans:
            return "SamTrans"
        case .SolTrans:
            return "SolTrans"
        default:
            return ""
        }
    }
    
    init(stringValue: String) {
        switch stringValue {
        case "VTA":
            self = .VTA
        case "BART":
            self = .BART
        case "CalTrain":
            self = .CalTrain
        case "Muni":
            self = .Muni
        case "Golden Gate Transit":
            self = .GoldenGateTransit
        case "AC Transit":
            self = .ACTransit
        case "Union City Transit":
            self = .UnionCity
        case "ACE":
            self = .ACE
        case "SamTrans":
            self = .SamTrans
        case "SolTrans":
            self = .SolTrans
        default:
            self = .zero
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
        case .VTA:
            return #imageLiteral(resourceName: "Tram")
        case .SamTrans:
            return #imageLiteral(resourceName: "Bus")
        case .SolTrans:
            return #imageLiteral(resourceName: "Bus")
        default:
            return #imageLiteral(resourceName: "CalTrain")
        }
    }
}
