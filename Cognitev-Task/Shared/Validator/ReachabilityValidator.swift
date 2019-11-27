//
//  ReachabilityValidator.swift
//  Cognitev-Task
//
//  Created by Ahmed Ramy on 11/27/19.
//  Copyright © 2019 Ahmed Ramy. All rights reserved.
//

import Foundation

typealias ToSeeIfIsReachable = ReachabilityValidator

class ReachabilityValidator: BaseValidator {
    func orThrow() throws {
        guard !Reachability.isConnectedToNetwork() else { return }
        throw ValidationError.unreachable
    }
}
