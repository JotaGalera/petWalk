import Foundation

protocol UserDefaultsRepository: AutoMockable {
    func saveDailySteps(_ steps: Int)
}

class UserDefaultsRepositoryImplementation: UserDefaultsRepository {
    private var userDefaultDataSource: UserDefaultsDataSource
    
    public init(userDefaultDataSource: UserDefaultsDataSource) {
        self.userDefaultDataSource = userDefaultDataSource
    }
    
    func saveDailySteps(_ steps: Int) {
        userDefaultDataSource.set(value: steps, forKey: .dailySteps)
    }
}
