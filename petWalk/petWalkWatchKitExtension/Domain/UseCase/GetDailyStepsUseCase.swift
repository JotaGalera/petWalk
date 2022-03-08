//
//  GetDailyStepsUseCase.swift
//  petWalk WatchKit Extension
//
//  Created by Galera, Javier on 6/2/22.
//

import Foundation

protocol GetDailyStepsUseCase: AutoMockable {
    func execute() async throws -> Int
}

class GetDailyStepsUseCaseImplementation: GetDailyStepsUseCase {
    private var healthStoreRepository: HealthStoreRepository
    
    public init(healthStoreRepository: HealthStoreRepository) {
        self.healthStoreRepository = healthStoreRepository
    }

    func execute() async throws -> Int {
        return try await healthStoreRepository.getDailySteps()
    }
}
