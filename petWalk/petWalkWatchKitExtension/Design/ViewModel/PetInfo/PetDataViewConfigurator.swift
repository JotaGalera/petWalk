//
//  PetDataViewConfigurator.swift
//  petWalkWatchKitExtension
//
//  Created by Galera, Javier on 17/3/22.
//

import Foundation

class PetDataViewConfigurator {
    @MainActor func configure() -> PetDataViewModel {
        let healthStoreDataSource = HealthStoreDataSourceImplementation()
        let healthStoreRepository = HealthStoreRepositoryImplementation(dataSource: healthStoreDataSource)
        
        let userDefaultDataSource = UserDefaultsDataSourceImplementation()
        let userDefaultRepository = UserDefaultsRepositoryImplementation(userDefaultDataSource: userDefaultDataSource)
        
        let getStepsUseCase = GetStepsUseCaseImplementation(healthStoreRepository: healthStoreRepository, userDefaultRepository: userDefaultRepository)
        let saveAccumulatedDailyStepsUseCase = SaveAccumulatedDailyStepsUseCaseImplementation(repository: userDefaultRepository)
        let saveTotalStepsUseCase = SaveTotalStepsUseCaseImplementation(repository: userDefaultRepository)
        let savePreviousAnimationProgressUseCase = SavePreviousAnimationProgressUseCaseImplementation(repository: userDefaultRepository)
        let getAccumulatedDailyStepsUseCase = GetAccumulatedDailyStepsUseCaseImplementation(repository: userDefaultRepository)
        let getPreviousAnimationProgressUseCase = GetPreviousAnimationProgressUseCaseImplementation(repository: userDefaultRepository)
        
        return PetDataViewModel(trackingManager: TrackingManagerImplementation.instance,
                                saveAccumulatedDailyStepsUseCase: saveAccumulatedDailyStepsUseCase,
                                saveTotalStepsUseCase: saveTotalStepsUseCase,
                                savePreviousAnimationProgressUseCase: savePreviousAnimationProgressUseCase,
                                getStepsUseCase: getStepsUseCase,
                                getAccumulatedDailyStepsUseCase: getAccumulatedDailyStepsUseCase,
                                getPreviousAnimationProgressUseCase: getPreviousAnimationProgressUseCase)
    }
}
