//
//  LocationMock.swift
//  Cognitev-TaskTests
//
//  Created by Ahmed Ramy on 11/29/19.
//  Copyright © 2019 Ahmed Ramy. All rights reserved.
//

import Foundation
import CoreLocation

@testable import Cognitev_Task

class LocationMock: LocationProtocol {
    var error: Error?
    var onFailure: ((Error) -> Void)?
    
    var location: CLLocation = CLLocation(latitude: 30, longitude: 30)
    
    func startTracking(_ onUpdate: @escaping ((CLLocation) -> Void)) {
        if let error = self.error {
            onFailure?(error)
        } else {
            onUpdate(location)
        }
    }
    
    func fetchLocationOneShot(_ onComplete: @escaping ((CLLocation) -> Void)) {
        if let error = self.error {
            onFailure?(error)
        } else {
            onComplete(location)
        }
    }
}
