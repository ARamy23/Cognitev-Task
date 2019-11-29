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
    
    func callModel<T, U>(model: T.Type, api: U) -> Observable<T> where T : Decodable, T : Encodable, U : BaseService {
        let provider = MoyaProvider<U>()
        return Observable.create { (observer) -> Disposable in
            provider.request(api) { (result) in
                switch result {
                case let .success(response):
                    do {
                        let parsedModel = try response.map(model)
                        observer.on(.next(parsedModel))
                    } catch let error {
                        observer.on(.error(error))
                    }
                case let .failure(error):
                    observer.on(.error(error))
                }
            }
            
            return Disposables.create()
        }
    }
}
