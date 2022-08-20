//
//  SetupPetRolViewFactory.swift
//  petWalkWatchKitExtension
//
//  Created by Galera, Javier on 20/8/22.
//

import Foundation

class SetupPetRolViewFactory {
    func make() -> SetupPetRolView {
        let viewModel = SetupPetRolViewModel()
        return SetupPetRolView(setupPetRolViewModel: viewModel)
    }
}
