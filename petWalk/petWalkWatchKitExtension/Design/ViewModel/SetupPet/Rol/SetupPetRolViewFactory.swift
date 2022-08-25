//
//  SetupPetRolViewFactory.swift
//  petWalkWatchKitExtension
//
//  Created by Galera, Javier on 20/8/22.
//

import Foundation

class SetupPetRolViewFactory {
    func make() -> SetupPetRolView {
        let viewModel = SetupPetRolViewModelFactory().make()
        return SetupPetRolView(setupPetRolViewModel: viewModel)
    }
}

private class SetupPetRolViewModelFactory {
    func make() -> SetupPetRolViewModel {
        let dataSource = UserDefaultsDataSourceImplementation()
        let repository = UserDefaultsRepositoryImplementation(userDefaultDataSource: dataSource)
        let savePetRolUseCase = SavePetRolUseCaseImplementation(repository: repository)
        return SetupPetRolViewModel(savePetRolUseCase: savePetRolUseCase)
    }
}
