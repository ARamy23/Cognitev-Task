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
        return URL(string: "https://api.themoviedb.org/3")!
    }
    
    var headers: [String: String]? {
        let headers: [String: String] = ["Content-type": "application/json"]
        return headers
    }
    
    var sampleData: Data {
        return Data()
    }
    
    func getDefaultParamters() -> [String: Any] {
        return ["api_key": Constants.apiKey]
    }
}
