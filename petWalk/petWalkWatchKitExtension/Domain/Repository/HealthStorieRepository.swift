import Foundation
import Combine

protocol HealthStoreRepository: AutoMockable {
    func requestAuthorization() async throws -> Bool
    func getSteps(date: Date) async throws -> Int
}
