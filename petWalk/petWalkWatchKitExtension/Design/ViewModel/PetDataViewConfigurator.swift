//
//  PetDataViewConfigurator.swift
//  petWalkWatchKitExtension
//
//  Created by Galera, Javier on 17/3/22.
//

import Foundation

class PetDataViewConfigurator {
    func configure() -> PetDataViewModel {
        let userDefaultDataSource = UserDefaultsDataSourceImplementation()
        let userDefaultRepository = UserDefaultsRepositoryImplementation(userDefaultDataSource: userDefaultDataSource)
        let getAccumulatedDailyStepsUseCase = GetAccumulatedDailyStepsUseCaseImplementation(repository: userDefaultRepository)
        
        return PetDataViewModel(getAccumulatedDailyStepsUseCase: getAccumulatedDailyStepsUseCase)
    }
}
