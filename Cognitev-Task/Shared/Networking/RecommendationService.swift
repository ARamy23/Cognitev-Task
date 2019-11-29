//
//  RecommendationService.swift
//  Cognitev-Task
//
//  Created by Ahmed Ramy on 11/27/19.
//  Copyright © 2019 Ahmed Ramy. All rights reserved.
//

import Foundation
import Moya

enum RecommendationService {
    case explore(_ lat: Double, _ long: Double, _ page: Int)
}

extension RecommendationService: BaseService {
    var path: String {
        switch self {
        case .explore:
            return "venues/explore"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case let .explore(lat, long, page):
            var params = getDefaultParamters()
            params["ll"] = "\(lat), \(long)"
            params["query"] = "cafe"
            params["offset"] = page
            params["limit"] = 20
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
}
