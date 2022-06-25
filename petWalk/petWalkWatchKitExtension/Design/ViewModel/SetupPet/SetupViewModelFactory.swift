//
//  SetupViewModelFactory.swift
//  petWalkWatchKitExtension
//
//  Created by Galera, Javier on 25/6/22.
//

import Foundation

class SetupViewFactory {
    @MainActor func make() -> SetupPetView {
        let viewModel = SetupViewModelFactory().make()
        return SetupPetView(setupPetViewModel: viewModel)
    }
}

private class SetupViewModelFactory {
    @MainActor func make() -> SetupPetViewModel {
        let dataSource = UserDefaultsDataSourceImplementation()
        let repository = UserDefaultsRepositoryImplementation(userDefaultDataSource: dataSource)
        let getPetDataUseCase = GetPetDataUseCaseImplementation(repository: repository)
        return SetupPetViewModel(getPetDataUseCase: getPetDataUseCase)
    }
}
