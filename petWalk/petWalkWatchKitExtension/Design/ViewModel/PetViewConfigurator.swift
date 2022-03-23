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
        let getDailyStepsUseCase = GetDailyStepsUseCaseImplementation(healthStoreRepository: healthStoreRepository)
        
        let userDefaultDataSource = UserDefaultsDataSourceImplementation()
        let userDefaultRepository = UserDefaultsRepositoryImplementation(userDefaultDataSource: userDefaultDataSource)
        
        let saveAccumulatedDailyStepsUseCase = SaveAccumulatedDailyStepsUseCaseImplementation(repository: userDefaultRepository)
        let saveTotalStepsUseCase = SaveTotalStepsUseCaseImplementation(repository: userDefaultRepository)
        let getAccumulatedDailyStepsUseCase = GetAccumulatedDailyStepsUseCaseImplementation(repository: userDefaultRepository)
        
        
        
        
        return PetViewModel(requestDailyStepsPermissionUseCase: requestDailyStepsPermissionUseCase,
                            saveAccumulatedDailyStepsUseCase: saveAccumulatedDailyStepsUseCase,
                                saveTotalDailyStepsUseCase: saveTotalStepsUseCase,
                                getDailyStepsUseCase: getDailyStepsUseCase,
                                getAccumulatedDailyStepsUseCase: getAccumulatedDailyStepsUseCase)
    }
}
