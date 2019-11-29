//
//  AppleLocationManager.swift
//  Cognitev-Task
//
//  Created by Ahmed Ramy on 11/27/19.
//  Copyright © 2019 Ahmed Ramy. All rights reserved.
//

import Foundation
import SwiftLocation
import CoreLocation

class AppleLocationManager: LocationProtocol {
    private var request: LocationRequest?
    
    var onFailure: ((Error) -> Void)?
    
    func startTracking(_ onUpdate: @escaping ((CLLocation) -> Void)) {
        request?.stop()
        request = Locator.subscribePosition(accuracy: .neighborhood, onUpdate: { (location) -> (Void) in
            onUpdate(location)
        }, onFail: { [weak self] (error, _) -> (Void) in
            self?.onFailure?(error)
        })
    }
    
    func fetchLocationOneShot(_ onComplete: @escaping ((CLLocation) -> Void)) {
        request?.stop()
        request = Locator.currentPosition(accuracy: .neighborhood, onSuccess: { (location) -> (Void) in
            onComplete(location)
        }, onFail: { [weak self] (error, _) -> (Void) in
            self?.onFailure?(error)
        })
    }
    
}

