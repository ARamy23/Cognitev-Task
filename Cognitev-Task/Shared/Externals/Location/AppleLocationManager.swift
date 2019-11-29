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
        request = Locator.subscribePosition(accuracy: .neighborhood, onUpdate: onUpdate, onFail: { [weak self] (error, location) -> (Void) in
            self?.onFailure?(error)
        })
    }
    
    func fetchLocationOneShot(_ onComplete: @escaping ((CLLocation) -> Void)) {
        request?.stop()
        request = Locator.currentPosition(accuracy: .neighborhood, onSuccess: onComplete, onFail: { [weak self] (error, location) -> (Void) in
            self?.onFailure?(error)
        })
    }
    
}

