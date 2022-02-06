//
//  GetDailyStepsUseCase.swift
//  petWalk WatchKit Extension
//
//  Created by Galera, Javier on 6/2/22.
//

import Foundation

protocol GetDailyStepsUseCase {
    func getTodaySteps(completion: @escaping (Int) -> Void)
}

class GetDailyStepsUseCaseImplementation: GetDailyStepsUseCase {
    private var repository: HealthStoreRepository
    
    public init(repository: HealthStoreRepository) {
        self.repository = repository
    }
    
    func getTodaySteps(completion: @escaping (Int) -> Void) {
        repository.getTodaySteps(completion: completion)
    }
}
