import Foundation

protocol UserDefaultRepository {
    func saveDailySteps(_ steps: Int)
}

class UserDefaultRepositoryImplementation: UserDefaultRepository {
    private var userDefaultDataSource: UserDefaultDataSource
    
    public init(userDefaultDataSource: UserDefaultDataSource) {
        self.userDefaultDataSource = userDefaultDataSource
    }
    
    func saveDailySteps(_ steps: Int) {
        userDefaultDataSource.set(value: steps, forKey: "dailySteps")
    }
}
