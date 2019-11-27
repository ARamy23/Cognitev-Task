//
//  AppleLocationManager.swift
//  Cognitev-Task
//
//  Created by Ahmed Ramy on 11/27/19.
//  Copyright © 2019 Ahmed Ramy. All rights reserved.
//

import Foundation
import RxSwift

class AppleLocationManager: LocationProtocol {
    func startTracking() {
        
    }
    
    func getCurrentLocation() -> Observable<(long: Double, lat: Double)> {
        return Observable.just((long: 30, lat: 30))
    }
}

