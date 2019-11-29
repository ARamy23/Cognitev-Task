//
//  NetworkMock.swift
//  Cognitev-TaskTests
//
//  Created by Ahmed Ramy on 11/29/19.
//  Copyright © 2019 Ahmed Ramy. All rights reserved.
//

import Foundation
import RxSwift

@testable import Cognitev_Task

class NetworkMock: NetworkProtocol {
    
    var object: Codable?
    var error: Error?
    
    init() { }
    
    init(error: Error) {
        self.error = error
    }
    
    init(object: Codable) {
        self.object = object
    }
    
    func callModel<T, U>(model: T.Type, api: U) -> Observable<T>  where T : Decodable, T : Encodable, U : BaseService {
        return Observable.create { observer -> Disposable in
            if let object = self.object {
                observer.onNext(object as! T)
            } else if let error = self.error {
                observer.on(.error(error))
            }
            
            return Disposables.create()
        }
    }
}
