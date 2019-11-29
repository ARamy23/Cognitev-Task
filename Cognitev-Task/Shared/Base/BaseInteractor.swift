//
//  BaseInteractor.swift
//  Cognitev-Task
//
//  Created by Ahmed Ramy on 11/27/19.
//  Copyright © 2019 Ahmed Ramy. All rights reserved.
//

import Foundation
import RxSwift

class BaseInteractor {
    var cache: CacheProtocol
    var network: NetworkProtocol
    
    init(network: NetworkProtocol, cache: CacheProtocol) {
        self.cache = cache
        self.network = network
    }
    
    func execute<T: Codable>(_ model: T.Type) -> Observable<T> {
        do {
            extract()
            try validate()
            return process(model)
        } catch let error {
            return Observable.create { (observer) -> Disposable in
                observer.on(.error(error))
                return Disposables.create()
            }
        }
    }
    
    func validate() throws {
        try ToSeeIfIsReachable().orThrow()
    }
    
    /// Use this to extract values from cache or network before you can execute the command
    func extract() {
        // Override
    }
    
    func process<T: Codable>(_ model: T.Type) -> Observable<T> {
        return Observable.create { (observer) -> Disposable in
            observer.on(.error(NSError(domain: "Error", code: 100, userInfo: nil)))
            return Disposables.create()
        }
    }
}
