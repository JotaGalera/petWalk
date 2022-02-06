//
//  RequestDailyStepsPermission.swift
//  petWalk WatchKit Extension
//
//  Created by Galera, Javier on 6/2/22.
//

import Foundation

protocol RequestDailyStepsPermissionUseCase {
    func execute(completion: @escaping (Bool) -> Void)
}

class RequestDailyStepsPermissionUseCaseImplementation: RequestDailyStepsPermissionUseCase {
    private var healthStoreRepository: HealthStoreRepository
    
    public init(healthStoreRepository: HealthStoreRepository) {
        self.healthStoreRepository = healthStoreRepository
    }
    
    func execute(completion: @escaping (Bool) -> Void) {
        healthStoreRepository.requestAuthorization(completion: completion)
    }
}
