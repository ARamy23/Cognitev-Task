//
//  HomeViewModel.swift
//  Cognitev-Task
//
//  Created by Ahmed Ramy on 11/27/19.
//  Copyright © 2019 Ahmed Ramy. All rights reserved.
//

import RxSwift
import RxCocoa
import CoreLocation

enum ExploreFeedFetchingStyle {
    case realtime
    case oneShot
}

final class HomeViewModel: BaseViewModel {
    let venues = BehaviorRelay<[GroupItem]>(value: [])
    private var location: LocationProtocol
    private var page: Int = 1
    private var updateStyle = BehaviorRelay<ExploreFeedFetchingStyle>(value: .realtime)
    
    init(location: LocationProtocol, cache: CacheProtocol, router: RouterProtocol, network: NetworkProtocol) {
        self.location = location
        super.init(cache: cache, router: router, network: network)
        self.location.onFailure = { [weak self] error in
            self?.router.toast(title: "Error", message: error.localizedDescription)
        }
    }
    
    fileprivate func handleFetchingLocation(_ location: CLLocation) {
        HomeFeedInteractor(page: self.page,
                           coordinates: (long: location.coordinate.longitude,
                                         lat: location.coordinate.latitude),
                           network: self.network,
                           cache: self.cache)
            .process(ExploreResponse.self)
            .subscribe(onNext: { [weak self] (response) in
                guard let self = self else { return }
                self.router.stopActivityIndicator()
                let items = response.response?.groups?.map { $0.items ?? [] } ?? [[]]
                let flattend = items.flatMap { $0 }
                let oldVenues = self.venues.value
                self.venues.accept(oldVenues + flattend)
                }, onError: { [weak self] (error) in
                    guard let self = self else { return }
                    self.router.stopActivityIndicator()
                    self.router.alert(title: "Error",
                                      message: error.localizedDescription,
                                      actions: [(title: "Ok", style: .default)])
            }).disposed(by: self.disposeBag)
        
    }
    
    func fetchExploreFeed() {
        router.startActivityIndicator()
        switch self.updateStyle.value {
        case .realtime:
            self.location.startTracking(handleFetchingLocation)
        case .oneShot:
            self.location.fetchLocationOneShot(handleFetchingLocation)
        }
    }
    
    func fetchMoreVenues() {
        self.updateStyle.accept(.oneShot)
        page += 1
        router.startActivityIndicator()
        self.location.fetchLocationOneShot(handleFetchingLocation)
    }
}

