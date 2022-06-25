//
//  PetViewModelFactory.swift
//  petWalk WatchKit Extension
//
//  Created by Galera, Javier on 6/2/22.
//

import Foundation

class PetViewFactory {
    @MainActor func make() -> PetView {
        let viewModel = PetViewModelFactory().make()
        return PetView(viewModel: viewModel)
    }
}

private class PetViewModelFactory {
    @MainActor func make() -> PetViewModel {
        let healthStoreDataSource = HealthStoreDataSourceImplementation()
        let healthStoreRepository = HealthStoreRepositoryImplementation(dataSource: healthStoreDataSource)
        
        let requestDailyStepsPermissionUseCase = RequestDailyStepsPermissionUseCaseImplementation(healthStoreRepository: healthStoreRepository)
        
        let userDefaultDataSource = UserDefaultsDataSourceImplementation()
        let userDefaultRepository = UserDefaultsRepositoryImplementation(userDefaultDataSource: userDefaultDataSource)
        
        let saveTrackingDailyStepsUseCase = SaveTrackingDailyStepsUseCaseImplementation(userDefaultRepository: userDefaultRepository)
        
        let getPetDataUseCase = GetPetDataUseCaseImplementation(repository: userDefaultRepository)
        
        return PetViewModel(requestDailyStepsPermissionUseCase: requestDailyStepsPermissionUseCase,
                            saveTrackingDailyStepsUseCase: saveTrackingDailyStepsUseCase,
                            getPetDataUseCase: getPetDataUseCase)
    }
}
