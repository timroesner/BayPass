//
//  GTFSService.swift
//  BayPass
//
//  Created by Ayesha Khan on 2/26/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON

private let GTFSprovider = MoyaProvider<GTFSService>()

public enum GTFSService {
    case gtfsoperators
    case stopFromStations
}

extension GTFSService: TargetType {
    public var baseURL: URL {
        return URL(string: "https://api.511.org")!
    }

    public var path: String {
        switch self {
        case .gtfsoperators:
            return "/transit/transit/gtfsoperators?api_key=11f56fe7-a97a-40db-9d94-130584c8bac6"
        case .stopFromStations:
            return "/transit/stops??api_key=11f56fe7-a97a-40db-9d94-130584c8bac6"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .gtfsoperators:
            return .get
        case .stopFromStations:
            return .get
        default:
            return .get
        }
    }

    public var sampleData: Data {
        return Data()
    }

    public var task: Task {
        return .requestPlain
    }

    public var headers: [String: String]? {
        return nil
    }
}

extension GTFSService {
    static func request(target: GTFSService, success successCallback: @escaping (Response) -> Void, error errorCallback: @escaping (Swift.Error) -> Void, failure failureCallback: @escaping (MoyaError) -> Void) {
        GTFSprovider.request(target) { result in
            switch result {
            case let .success(response):
                // 1:
                if response.statusCode >= 200 && response.statusCode <= 300 {
                    successCallback(response)
                } else {
                    // 2:
                    let error = NSError(domain: "com.vsemenchenko.networkLayer", code: 0, userInfo: [NSLocalizedDescriptionKey: "Parsing Error"])
                    errorCallback(error)
                }
            case let .failure(error):
                // 3:
                failureCallback(error)
            }
        }
    }
}
