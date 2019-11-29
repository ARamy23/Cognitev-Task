//
//  CacheMock.swift
//  Cognitev-TaskTests
//
//  Created by Ahmed Ramy on 11/29/19.
//  Copyright © 2019 Ahmed Ramy. All rights reserved.
//

import Foundation

@testable import Cognitev_Task

class CacheMock: CacheProtocol {
    
    var dataStorage: [String: Any] = [:]
    
    func getObject<T>(_ object: T.Type, key: String) -> T? where T : Decodable, T : Encodable {
        return dataStorage[key] as? T
    }
    
    func getData(key: String) -> [Data]? {
        return (dataStorage[key] as? Data).map({[$0]})
    }
    
    func saveData(_ data: Data?, key: String) {
        dataStorage[key] = data
    }
    
    func getObject<T>(_ object: T, key: String) -> T? {
        return dataStorage[key] as? T
    }
    
    func saveObject<T>(_ object: T, key: String) {
        dataStorage[key] = object
    }
    
    func removeObject<T>(object: T.Type, key: String) where T : Decodable, T : Encodable {
        dataStorage.removeValue(forKey: key)
    }
}
