//
//  Result.swift
//  BayPass
//
//  Created by Ayesha Khan on 2/11/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

enum Result<T, U> where U: Error  {
    case success(T)
    case failure(U)
}
