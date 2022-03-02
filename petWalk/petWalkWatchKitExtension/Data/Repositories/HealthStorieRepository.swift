import Foundation

protocol HealthStoreRepository: AutoMockable {
    func requestAuthorization(completion: @escaping (Bool) -> Void)
    func getDailySteps(completion: @escaping (Int) -> Void)
}

class HealthStoreRepositoryImplementation: HealthStoreRepository {
    private var dataSource: HealthStoreDataSource
    
    public init(dataSource: HealthStoreDataSource) {
        self.dataSource = dataSource
    }
    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        dataSource.requestAuthorization(completion: completion)
    }
    
    func getDailySteps(completion: @escaping (Int) -> Void) {
        dataSource.getDailySteps(completion: completion)
    }
}
