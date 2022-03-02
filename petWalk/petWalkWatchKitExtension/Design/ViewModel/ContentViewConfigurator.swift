//
//  ContentViewConfigurator.swift
//  petWalk WatchKit Extension
//
//  Created by Galera, Javier on 6/2/22.
//

import Foundation

class ContentViewConfigurator {
    func configure() -> ContentViewModel {
        let healthStoreDataSource = HealthStoreDataSourceImplementation()
        let healthStoreRepository = HealthStoreRepositoryImplementation(dataSource: healthStoreDataSource)
        
        let requestDailyStepsPermissionUseCase = RequestDailyStepsPermissionUseCaseImplementation(healthStoreRepository: healthStoreRepository)
        let getDailyStepsUseCase = GetDailyStepsUseCaseImplementation(healthStoreRepository: healthStoreRepository)
        
        let userDefaultDataSource = UserDefaultsDataSourceImplementation()
        let userDefaultRepository = UserDefaultsRepositoryImplementation(userDefaultDataSource: userDefaultDataSource)
        
        let saveDailyStepsUseCase = SaveDailyStepsUseCaseImplementation(repository: userDefaultRepository)
        let saveTotalStepsUseCase = SaveTotalStepsUseCaseImplementation(repository: userDefaultRepository)
        let getAccumulatedDailyStepsUseCase = GetAccumulatedDailyStepsUseCaseImplementation(repository: userDefaultRepository)
        
        
        
        
        return ContentViewModel(requestDailyStepsPermissionUseCase: requestDailyStepsPermissionUseCase,
                                saveDailyStepsUseCase: saveDailyStepsUseCase,
                                saveTotalDailyStepsUseCase: saveTotalStepsUseCase,
                                getDailyStepsUseCase: getDailyStepsUseCase,
                                getAccumulatedDailyStepsUseCase: getAccumulatedDailyStepsUseCase)
    }
}
