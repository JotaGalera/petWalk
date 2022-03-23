import Foundation

protocol UserDefaultsRepository: AutoMockable {
    func saveAccumulatedDailySteps(_ steps: Int)
    func saveTotalSteps(_ steps: Int)
    func saveDateDailySteps(_ date: Date)
    func getAccumulatedDailySteps() -> Int
    func getTotalSteps() -> Int
    func getDateDailySteps() -> Date
}

class UserDefaultsRepositoryImplementation: UserDefaultsRepository {
    private var userDefaultDataSource: UserDefaultsDataSource
    
    public init(userDefaultDataSource: UserDefaultsDataSource) {
        self.userDefaultDataSource = userDefaultDataSource
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
    
    func getAccumulatedDailySteps() -> Int {
        return userDefaultDataSource.get(forKey: .accumulatedDailySteps) ?? 0
    }
    
    func getTotalSteps() -> Int {
        return userDefaultDataSource.get(forKey: .totalSteps) ?? 0
    }
    
    func getDateDailySteps() -> Date {
        return userDefaultDataSource.get(forKey: .dateDailySteps) ?? Date()
    }
}
