//
//  GTFSClient.swift
//  BayPass
//
//  Created by Ayesha Khan on 2/11/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//
import Foundation

class GTFSClient: APIClient {
    let session: URLSession

    init(configuration: URLSessionConfiguration) {
        session = URLSession(configuration: configuration)
    }

    convenience init() {
        self.init(configuration: .default)
    }

    // in the signature of the function in the success case we define the Class type thats is the generic one in the API
    func getGTFSAgencies(from gtfsoperators: GTFS, completion: @escaping (Result<Agencies?, APIError>) -> Void) {
        fetch(with: gtfsoperators.request, decode: { json -> Agencies? in
            guard let gtfsoperatorsResult = json as? Agencies else { return nil }
            return gtfsoperatorsResult
        }, completion: completion)
    }
}
