//
//  MoyaManager.swift
//  Cognitev-Task
//
//  Created by Ahmed Ramy on 11/27/19.
//  Copyright © 2019 Ahmed Ramy. All rights reserved.
//

import Foundation
import Moya
import RxSwift

class MoyaManager: NetworkProtocol {
    static var ongoingRequests = [Cancellable]()
    
    func callModel<T, U>(model: T.Type, api: U) -> Observable<T> where T : Decodable, T : Encodable, U : BaseService {
        let provider = MoyaProvider<U>(plugins: [NetworkLoggerPlugin(verbose: true)])
        return provider
            .rx
            .request(api)
            .asObservable()
            .map(model)
            .debug("Debugging API: \(api.self)")
    }
}
