//
//  UserDefaultMock.swift
//  petWalkWatchKitAppTests
//
//  Created by Galera, Javier on 27/5/22.
//

import Foundation
@testable import petWalkWatchKitExtension

class UserDefaultDataSourceMock: UserDefaultsDataSource {
    var getCallsCount = 0
    var getParamForKeyReceived: UserDefaultsKeys!
    var getReturnValue: Any!
    var trackingDailyStepsPermissionReturnValue = true
    var accumulatedDailyStepsReturnValue = 10
    var totalStepsReturnValue = 100
    var dateDailyStepsReturnValue = Date()
    var previousAnimationProgressReturnValue = 40.0
    var petNameReturnValue = "nameMock"
    var petLevelReturnValue = 1
    var setCallsCount = 0
    var setParamValueReceived: Any!
    var setParamForKeyReceived: UserDefaultsKeys!
    
    func get<T>(forKey: UserDefaultsKeys) -> T? {
        getCallsCount += 1
        getParamForKeyReceived = forKey
        switch forKey {
        case .trackingDailyStepsPermission:
            getReturnValue = trackingDailyStepsPermissionReturnValue
        case .accumulatedDailySteps:
            getReturnValue = accumulatedDailyStepsReturnValue
        case .totalSteps:
            getReturnValue = totalStepsReturnValue
        case .dateDailySteps:
            getReturnValue = dateDailyStepsReturnValue
        case .previousAnimationProgress:
            getReturnValue = previousAnimationProgressReturnValue
        case .petName:
            getReturnValue = petNameReturnValue
        case .petLevel:
            getReturnValue = petLevelReturnValue
        }
        return getReturnValue as? T
    }
    
    func set<T>(value: T, forKey: UserDefaultsKeys) {
        setCallsCount += 1
        setParamValueReceived = value
        setParamForKeyReceived = forKey
    }
}
