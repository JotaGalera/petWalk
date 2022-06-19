//
//  SecureQuestionViewModelFactory.swift
//  petWalkWatchKitExtension
//
//  Created by Galera, Javier on 19/6/22.
//

import SwiftUI

class SecureQuestionViewModelFactory {
    @MainActor func make() -> SecureQuestionViewModel {
        let dataSource = UserDefaultsDataSourceImplementation()
        let repository = UserDefaultsRepositoryImplementation(userDefaultDataSource: dataSource)
        let savePetNameUseCase = SavePetNameUseCaseImplementation(repository: repository)
        
        return SecureQuestionViewModel(savePetNameUseCase: savePetNameUseCase)
    }
}
