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
    let fetchStyle = BehaviorRelay<ExploreFeedFetchingStyle>(value: .realtime)
    private var location: LocationProtocol
    private var page: Int = 1
    
    init(location: LocationProtocol, cache: CacheProtocol, router: RouterProtocol, network: NetworkProtocol) {
        self.location = location
        super.init(cache: cache, router: router, network: network)
        self.location.onFailure = { [weak self] error in
            self?.router.stopActivityIndicator()
            self?.router.toast(title: "Error", message: error.localizedDescription)
        }
    }
    
    fileprivate func fetchVenuesRemotely(_ location: CLLocation) {
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
            self.cache.saveObject(oldVenues + flattend, key: "\(location.coordinate.longitude), \(location.coordinate.latitude) page: \(self.page)")
            }, onError: { [weak self] (error) in
                guard let self = self else { return }
                self.router.stopActivityIndicator()
                self.router.alert(title: "Error",
                                  message: error.localizedDescription,
                                  actions: [(title: "Ok", style: .default)])
        }).disposed(by: self.disposeBag)
    }
    
    /// handles received location from location layer and asks the repository to get feed
    /// - Parameter location: incoming location from location layer
    fileprivate func handleFetchingLocation(_ location: CLLocation) {
        if let venues = self.cache.getObject([GroupItem].self, key: "\(location.coordinate.longitude), \(location.coordinate.latitude) page: \(self.page)") {
            self.router.stopActivityIndicator()
            self.venues.accept(venues)
        } else {
            fetchVenuesRemotely(location)
        }
        
    }
    
    /// fetches explore feed
    /// - Parameter fetchStyle: decides wether fetching should be continously whenever user changes location, or oneShot fetching for single use like pagination
    func fetchExploreFeed() {
        router.startActivityIndicator()
        switch self.fetchStyle.value {
        case .realtime:
            self.location.startTracking(handleFetchingLocation)
        case .oneShot:
            self.location.fetchLocationOneShot(handleFetchingLocation)
        }
    }
    
    /// This turns fetching style to .oneShot since pagination means u r already exploring in the same location, so no need to fetch continously
    func fetchMoreVenues() {
        page += 1
        self.fetchStyle.accept(.oneShot)
        fetchExploreFeed()
    }
}

