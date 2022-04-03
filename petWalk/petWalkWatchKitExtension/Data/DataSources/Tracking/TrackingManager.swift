//
//  TrackingManager.swift
//  petWalkWatchKitExtension
//
//  Created by Galera, Javier on 3/4/22.
//

import Foundation

protocol TrackingManager: AutoMockable {
    func isTrackingDailyStepsEnabled() -> Bool
}

class TrackingManagerImplementation: TrackingManager {
    static let instance = TrackingManagerImplementation(userDefaultDataSource: UserDefaultsDataSourceImplementation())
    
    private let userDefaultDataSource: UserDefaultsDataSource
    
    init(userDefaultDataSource: UserDefaultsDataSource) {
        self.userDefaultDataSource = userDefaultDataSource
    }
    
    func isTrackingDailyStepsEnabled() -> Bool {
        return userDefaultDataSource.get(forKey: UserDefaultsKeys.trackingDailyStepsPermission) ?? false
    }
}
