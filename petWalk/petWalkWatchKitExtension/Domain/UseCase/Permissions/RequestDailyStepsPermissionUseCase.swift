//
//  RequestDailyStepsPermission.swift
//  petWalk WatchKit Extension
//
//  Created by Galera, Javier on 6/2/22.
//

import Foundation

protocol RequestDailyStepsPermissionUseCase: AutoMockable {
    func execute() async throws -> Bool
}

class RequestDailyStepsPermissionUseCaseImplementation: RequestDailyStepsPermissionUseCase {
    private var healthStoreRepository: HealthStoreRepository
    
    public init(healthStoreRepository: HealthStoreRepository) {
        self.healthStoreRepository = healthStoreRepository
    }
    
    func execute() async throws -> Bool {
        return try await healthStoreRepository.requestAuthorization()
    }
}
