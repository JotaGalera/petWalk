import Foundation
import Combine

protocol HealthStoreRepository: AutoMockable {
    func requestAuthorization() async throws -> Bool
    func getSteps(date: Date) async throws -> Int
}

class HealthStoreRepositoryImplementation: HealthStoreRepository {
    private var dataSource: HealthStoreDataSource
    
    public init(dataSource: HealthStoreDataSource) {
        self.dataSource = dataSource
    }

    func requestAuthorization() async throws -> Bool {
        return try await dataSource.requestAuthorization()
    }
    
    func getSteps(date: Date) async throws -> Int {
        return try await dataSource.getSteps(date: date)
    }
}
