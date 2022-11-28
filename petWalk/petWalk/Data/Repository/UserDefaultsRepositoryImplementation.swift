//
//  UserDefaultsRepositoryImplementation.swift
//  petWalk
//
//  Created by Galera, Javier on 28/11/22.
//

import Foundation

class UserDefaultsRepositoryImplementation: UserDefaultsRepository {
    private let userDefaultsDataSource: UserDefaultsDataSource
    
    init(userDefaultsDataSource: UserDefaultsDataSource) {
        self.userDefaultsDataSource = userDefaultsDataSource
    }
    
    func getPetName() -> String {
        userDefaultsDataSource.get(forKey: .petName) ?? ""
    }
    
    func getPetLevel() -> Int {
        userDefaultsDataSource.get(forKey: .petLevel) ?? 0
    }
    
    func getPetRol() -> String {
        userDefaultsDataSource.get(forKey: .petRol) ?? ""
    }
    
    
}
