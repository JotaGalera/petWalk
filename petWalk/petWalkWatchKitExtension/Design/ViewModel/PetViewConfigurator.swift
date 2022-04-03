//
//  ContentViewConfigurator.swift
//  petWalk WatchKit Extension
//
//  Created by Galera, Javier on 6/2/22.
//

import Foundation

class PetViewConfigurator {
    @MainActor func configure() -> PetViewModel {
        let healthStoreDataSource = HealthStoreDataSourceImplementation()
        let healthStoreRepository = HealthStoreRepositoryImplementation(dataSource: healthStoreDataSource)
        
        let requestDailyStepsPermissionUseCase = RequestDailyStepsPermissionUseCaseImplementation(healthStoreRepository: healthStoreRepository)
        
        let userDefaultDataSource = UserDefaultsDataSourceImplementation()
        let userDefaultRepository = UserDefaultsRepositoryImplementation(userDefaultDataSource: userDefaultDataSource)
        
        let saveTrackingDailyStepsUseCase = SaveTrackingDailyStepsUseCaseImplementation(userDefaultRepository: userDefaultRepository)
        
        return PetViewModel(requestDailyStepsPermissionUseCase: requestDailyStepsPermissionUseCase,
                            saveTrackingDailyStepsUseCase: saveTrackingDailyStepsUseCase)
    }
}
