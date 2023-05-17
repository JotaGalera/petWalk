//
//  SetupViewModelFactory.swift
//  petWalkWatchKitExtension
//
//  Created by Galera, Javier on 25/6/22.
//

import Foundation
import SwiftUI

class SetupPetNameViewFactory {
    @MainActor func make(isRolSelected: Binding<Bool>) -> SetupPetNameView {
        let viewModel = SetupPetNameViewModelFactory().make()
        return SetupPetNameView(setupPetNameViewModel: viewModel, isRolSelected: isRolSelected)
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
