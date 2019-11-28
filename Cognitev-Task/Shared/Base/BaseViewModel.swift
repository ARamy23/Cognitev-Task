//
//  BaseViewModel.swift
//  Cognitev-Task
//
//  Created by Ahmed Ramy on 11/27/19.
//  Copyright © 2019 Ahmed Ramy. All rights reserved.
//

import RxSwift

class BaseViewModel {
    var router: RouterProtocol
    var cache: CacheProtocol
    var network: NetworkProtocol
    
    var disposeBag = DisposeBag()
    
    init(cache: CacheProtocol, router: RouterProtocol, network: NetworkProtocol) {
        self.cache = cache
        self.router = router
        self.network = network
    }
    
    func handleError(error: Error) {
        router.alert(title: "Error", message: error.localizedDescription, actions: [(title: "Ok", style: .default)])
    }
}
