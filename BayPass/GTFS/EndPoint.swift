//
//  EndPoint.swift
//  BayPass
//
//  Created by Ayesha Khan on 2/11/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import Foundation

protocol Endpoint {
    var base: String { get }
    var path: String { get }
}

extension Endpoint {
    var apiKey: String {
        return "api_key=11f56fe7-a97a-40db-9d94-130584c8bac6"
    }

    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        components.query = apiKey
        return components
    }

    var request: URLRequest {
        let url = urlComponents.url!
        return URLRequest(url: url)
    }
}
