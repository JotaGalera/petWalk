//
//  SetupViewModelFactory.swift
//  petWalkWatchKitExtension
//
//  Created by Galera, Javier on 25/6/22.
//

import Foundation

class SetupPetNameViewFactory {
    @MainActor func make() -> SetupPetNameView {
        let viewModel = SetupPetNameViewModelFactory().make()
        return SetupPetNameView(setupPetNameViewModel: viewModel)
    }
}

private class SetupPetNameViewModelFactory {
    @MainActor func make() -> SetupPetNameViewModel {
        let dataSource = UserDefaultsDataSourceImplementation()
        let repository = UserDefaultsRepositoryImplementation(userDefaultDataSource: dataSource)
        let getPetDataUseCase = GetPetDataUseCaseImplementation(repository: repository)
        return SetupPetNameViewModel(getPetDataUseCase: getPetDataUseCase)
    }
}
