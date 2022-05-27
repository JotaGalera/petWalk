//
//  getStepsUseCase.swift
//  petWalk WatchKit Extension
//
//  Created by Galera, Javier on 6/2/22.
//

import Foundation

protocol GetStepsUseCase: AutoMockable {
    func execute() async throws -> Int
}

class GetStepsUseCaseImplementation: GetStepsUseCase {
    private var healthStoreRepository: HealthStoreRepository
    private var userDefaultRepository: UserDefaultsRepository
    
    public init(healthStoreRepository: HealthStoreRepository, userDefaultRepository: UserDefaultsRepository) {
        self.healthStoreRepository = healthStoreRepository
        self.userDefaultRepository = userDefaultRepository
    }

    func execute() async throws -> Int {
        let lastTimeAppWasOpened = userDefaultRepository.getDateDailySteps()
        
        return try await healthStoreRepository.getSteps(date: lastTimeAppWasOpened)
    }
}
