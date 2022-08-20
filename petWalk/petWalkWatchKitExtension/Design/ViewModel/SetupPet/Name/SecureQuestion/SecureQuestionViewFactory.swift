//
//  SecureQuestionViewModelFactory.swift
//  petWalkWatchKitExtension
//
//  Created by Galera, Javier on 19/6/22.
//

import SwiftUI

class SecureQuestionViewFactory {
    @MainActor func make(petName: Binding<String>) -> SecureQuestionView {
        let viewModel = SecureQuestionViewModelFactory().make()
        return SecureQuestionView(petName: petName, viewModel: viewModel)
    }
}

private class SecureQuestionViewModelFactory {
    @MainActor func make() -> SecureQuestionViewModel {
        let dataSource = UserDefaultsDataSourceImplementation()
        let repository = UserDefaultsRepositoryImplementation(userDefaultDataSource: dataSource)
        let savePetNameUseCase = SavePetNameUseCaseImplementation(repository: repository)
        
        return SecureQuestionViewModel(savePetNameUseCase: savePetNameUseCase)
    }
}
