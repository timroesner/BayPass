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
            return "Golden Gate\nTransit"
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

    init(googleMapsValue: String) {
        switch googleMapsValue {
        case "VTA":
            self = .VTA
        case "Bay Area Rapid Transit":
            self = .BART
        case "Caltrain":
            self = .CalTrain
        case "San Francisco Municipal Transportation Agency":
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

    func getColor() -> UIColor {
        switch self {
        case .ACE:
            return #colorLiteral(red: 0.6209517717, green: 0.3887558877, blue: 0.8284057975, alpha: 1)
        case .ACTransit:
            return #colorLiteral(red: 0.2426148951, green: 0.77398628, blue: 0.5919234753, alpha: 1)
        case .BART:
            return #colorLiteral(red: 0.2225468159, green: 0.5167737603, blue: 0.8060272932, alpha: 1)
        case .CalTrain:
            return #colorLiteral(red: 0.8666666667, green: 0.3294117647, blue: 0.2549019608, alpha: 1)
        case .GoldenGateTransit:
            return #colorLiteral(red: 0.3713163137, green: 0.7446632385, blue: 0.5321159363, alpha: 1)
        case .Muni:
            return #colorLiteral(red: 0.8471637368, green: 0.2528677583, blue: 0.4470937252, alpha: 1)
        case .UnionCity:
            return #colorLiteral(red: 0.2191202641, green: 0.5643225312, blue: 0.8827003837, alpha: 1)
        case .VTA:
            return #colorLiteral(red: 0.2041481137, green: 0.5105623603, blue: 0.7108158469, alpha: 1)
        case .SamTrans:
            return #colorLiteral(red: 0.3274793029, green: 0.347738862, blue: 0.8402771354, alpha: 1)
        case .SolTrans:
            return #colorLiteral(red: 0.9531665444, green: 0.6216368079, blue: 0.2471764088, alpha: 1)
        case .zero:
            return .black
        }
    }
}
