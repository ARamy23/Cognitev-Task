//
//  ValidatorError.swift
//  Cognitev-Task
//
//  Created by Ahmed Ramy on 11/27/19.
//  Copyright © 2019 Ahmed Ramy. All rights reserved.
//

import Foundation

enum ValidationError: Error {
    case unreachable
    
    var message: String {
        switch self {
        case .unreachable: return "No Internet Connection, Please try again later"
        }
    }
}

extension ValidationError: LocalizedError {
    public var errorDescription: String? {
        return self.message
    }
}
