//
//  PetDataViewModelFactory.swift
//  petWalkWatchKitExtension
//
//  Created by Galera, Javier on 17/3/22.
//

import Foundation

class PetDataViewFactory {
    @MainActor func make(expToRaiseNextLevel: Int) -> PetDataView {
        let viewModel = PetDataViewModelFactory().make(expToRaiseNextLevel: expToRaiseNextLevel)
        return PetDataView(viewModel: viewModel)
    }
}

private class PetDataViewModelFactory {
    @MainActor func make(expToRaiseNextLevel: Int) -> PetDataViewModel {
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
                                getPreviousAnimationProgressUseCase: getPreviousAnimationProgressUseCase,
                                expToRaiseNextLevel: expToRaiseNextLevel)
    }
}
