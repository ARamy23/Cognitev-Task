//
//  HomeInteractor.swift
//  Cognitev-Task
//
//  Created by Ahmed Ramy on 11/27/19.
//  Copyright © 2019 Ahmed Ramy. All rights reserved.
//

import Foundation
import RxSwift

final class HomeFeedInteractor: BaseInteractor {
    private var page: Int
    private var coordinates: (long: Double, lat: Double)
    
    init(page: Int, coordinates: (long: Double, lat: Double), network: NetworkProtocol, cache: CacheProtocol) {
        self.page = page
        self.coordinates = coordinates
        super.init(network: network, cache: cache)
    }
    
    override func process<T>(_ model: T.Type) -> Observable<T> where T : Decodable, T : Encodable {
        network.callModel(model: model, api: RecommendationService.explore(coordinates.lat, coordinates.long, page))
    }
}
