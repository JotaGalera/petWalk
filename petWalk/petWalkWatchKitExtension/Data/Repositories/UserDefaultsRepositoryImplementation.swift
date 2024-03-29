//
//  UserDefaultsRepositoryImplementation.swift
//  petWalkWatchKitExtension
//
//  Created by Galera, Javier on 28/11/22.
//
import Foundation

class UserDefaultsRepositoryImplementation: UserDefaultsRepository {
    private var userDefaultDataSource: UserDefaultsDataSource
    
    public init(userDefaultDataSource: UserDefaultsDataSource) {
        self.userDefaultDataSource = userDefaultDataSource
    }
    
    func getAccumulatedDailySteps() -> Int {
        return userDefaultDataSource.get(forKey: .accumulatedDailySteps) ?? 0
    }
    
    func getTotalSteps() -> Int {
        return userDefaultDataSource.get(forKey: .totalSteps) ?? 0
    }
    
    func getDateDailySteps() -> Date {
        return userDefaultDataSource.get(forKey: .dateDailySteps) ?? Date()
    }
    
    func getPreviousAnimationProgress() -> Double {
        return userDefaultDataSource.get(forKey: .previousAnimationProgress) ?? 0
    }
    
    func getPetName() -> String {
        return userDefaultDataSource.get(forKey: .petName) ?? ""
    }
    
    func getPetLevel() -> Int {
        return userDefaultDataSource.get(forKey: .petLevel) ?? 1
    }
    
    func getPetRol() -> String {
        return userDefaultDataSource.get(forKey: .petRol) ?? ""
    }
    
    func saveTrackingDailySteps(_ permission: Bool) {
        userDefaultDataSource.set(value: permission, forKey: .trackingDailyStepsPermission)
    }
    
    func saveAccumulatedDailySteps(_ steps: Int) {
        userDefaultDataSource.set(value: steps, forKey: .accumulatedDailySteps)
    }
    
    func saveTotalSteps(_ steps: Int) {
        userDefaultDataSource.set(value: steps, forKey: .totalSteps)
    }
    
    func saveDateDailySteps(_ date: Date) {
        userDefaultDataSource.set(value: date, forKey: .dateDailySteps)
    }
    
    func savePetName(_ name: String) {
        userDefaultDataSource.set(value: name, forKey: .petName)
    }
    
    func savePreviousAnimationProgress(_ previousAnimationProgress: Double) {
        userDefaultDataSource.set(value: previousAnimationProgress, forKey: .previousAnimationProgress)
    }
    
    func savePetLevel(_ level: Int) {
        userDefaultDataSource.set(value: level, forKey: .petLevel)
    }
    
    func savePetRol(_ rol: String) {
        userDefaultDataSource.set(value: rol, forKey: .petRol)
    }
}
