//
//  UserDefaultsDataSource.swift
//  petWalk
//
//  Created by Galera, Javier on 28/11/22.
//

import Foundation

protocol UserDefaultsDataSource {
    func get<T>(forKey: UserDefaultsKeys) -> T?
    func set<T>(value: T, forKey: UserDefaultsKeys)
}

class UserDefaultsDataSourceImplementation: UserDefaultsDataSource {
    private var userDefault: UserDefaults
    
    init(userDefault: UserDefaults = UserDefaults.standard) {
        self.userDefault = userDefault
    }
    
    func get<T>(forKey: UserDefaultsKeys) -> T? {
        return userDefault.object(forKey: forKey.rawValue) as? T
    }
    
    func set<T>(value: T, forKey: UserDefaultsKeys) {
        self.userDefault.set(value, forKey: forKey.rawValue)
    }
}

