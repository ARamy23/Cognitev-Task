//
//  KeychainManager.swift
//  Cognitev-Task
//
//  Created by Ahmed Ramy on 11/27/19.
//  Copyright © 2019 Ahmed Ramy. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

final class KeychainManager: CacheProtocol {
    func getData(key: String) -> [Data]? {
        return KeychainWrapper.standard.data(forKey: key).map { [$0] }
    }
    
    func saveData(_ data: Data?, key: String) {
        guard let data = data else { return }
        KeychainWrapper.standard.set(data, forKey: key, withAccessibility: .whenUnlocked)
    }
    
    func getObject<T>(_ object: T.Type, key: String) -> T? where T : Decodable, T : Encodable {
        if object is String.Type {
            return getString(key: key) as? T
        } else {
            return getData(key: key)?[0].decode(object)
        }
    }
    
    private func getString(key: String) -> String? {
        return KeychainWrapper.standard.string(forKey: key)
    }
    
    private func saveString(_ object: String, key: String) {
        KeychainWrapper.standard.set(object, forKey: key)
    }
    
    func saveObject<T>(_ object: T, key: String) where T : Decodable, T : Encodable {
        if object is String {
            saveString(object as! String, key: key)
        } else {
            saveData(object.encode(), key: key)
        }
    }
    
    func removeObject<T>(object: T.Type, key: String) where T : Decodable, T : Encodable {
        KeychainWrapper.standard.removeObject(forKey: key)
    }
    
    
}
