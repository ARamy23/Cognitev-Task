//
//  BaseService.swift
//  Cognitev-Task
//
//  Created by Ahmed Ramy on 11/27/19.
//  Copyright © 2019 Ahmed Ramy. All rights reserved.
//

import Moya

protocol BaseService: TargetType { }

extension BaseService {
    var baseURL: URL {
        return URL(string: "https://api.foursquare.com/v2/")!
    }
    
    var headers: [String: String]? {
        let headers: [String: String] = ["Content-type": "application/json"]
        return headers
    }
    
    var sampleData: Data {
        return Data()
    }
    
    func getDefaultParamters() -> [String: Any] {
        return ["client_id": String.clientID,
                "client_secret": String.clientSecret,
                "v": 20191101] // v represents version of api where the value is date in format of YYYYMMDD
    }
}
