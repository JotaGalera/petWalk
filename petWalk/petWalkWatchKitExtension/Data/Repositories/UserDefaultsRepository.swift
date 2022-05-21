import Foundation

protocol UserDefaultsRepository: AutoMockable {
    func getAccumulatedDailySteps() -> Int
    func saveAccumulatedDailySteps(_ steps: Int)
    
    func getTotalSteps() -> Int
    func saveTotalSteps(_ steps: Int)
    
    func getDateDailySteps() -> Date
    func saveDateDailySteps(_ date: Date)
    
    func getPreviousAnimationProgress() -> Double
    func savePreviousAnimationProgress(_ previousAnimationProgress: Double)
    
    func saveTrackingDailySteps(_ permission: Bool)
}

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
    
    func savePreviousAnimationProgress(_ previousAnimationProgress: Double) {
        userDefaultDataSource.set(value: previousAnimationProgress, forKey: .previousAnimationProgress)
    }
}
