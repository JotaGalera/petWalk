//
//  GetDailyStepsUseCase.swift
//  petWalk WatchKit Extension
//
//  Created by Galera, Javier on 6/2/22.
//

import Foundation

protocol GetDailyStepsUseCase: AutoMockable {
    func execute(completion: @escaping (Int) -> Void)
}

class GetDailyStepsUseCaseImplementation: GetDailyStepsUseCase {
    private var healthStoreRepository: HealthStoreRepository
    
    public init(healthStoreRepository: HealthStoreRepository) {
        self.healthStoreRepository = healthStoreRepository
    }
    
    func execute(completion: @escaping (Int) -> Void) {
        healthStoreRepository.getDailySteps(completion: completion)
    }
}
