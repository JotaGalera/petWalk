//
//  SecureQuestionViewModelFactory.swift
//  petWalkWatchKitExtension
//
//  Created by Galera, Javier on 19/6/22.
//

import SwiftUI

class SecureQuestionViewFactory {
    @MainActor func make(petName: Binding<String>, isRolSelected: Binding<Bool>) -> SecureQuestionView {
        let viewModel = SecureQuestionViewModelFactory().make()
        return SecureQuestionView(petName: petName, viewModel: viewModel, isRolSelected: isRolSelected)
    }
}

private class SecureQuestionViewModelFactory {
    @MainActor func make() -> SecureQuestionViewModel {
        let dataSource = UserDefaultsDataSourceImplementation()
        let repository = UserDefaultsRepositoryImplementation(userDefaultDataSource: dataSource)
        let savePetNameUseCase = SavePetNameUseCaseImplementation(repository: repository)
        let savePetRolUseCase = SavePetRolUseCaseImplementation(repository: repository)
        
        return SecureQuestionViewModel(savePetNameUseCase: savePetNameUseCase, savePetRolUseCase: savePetRolUseCase)
    }
}
