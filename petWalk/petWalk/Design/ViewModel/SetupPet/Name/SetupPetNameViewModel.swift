//
//  SetupPetNameViewModel.swift
//  petWalk
//
//  Created by Galera, Javier on 1/12/22.
//

import Foundation

class SetupPetNameViewModel: ObservableObject {
    private let getPetDataUseCase: GetPetDataUseCase
    
    init(getPetDataUseCase: GetPetDataUseCase) {
        self.getPetDataUseCase = getPetDataUseCase
    }
    
    func canContinueWithNextView() -> Bool {
        guard let petData = getPetDataUseCase.execute() else {
            return false
        }
        return petData.name != ""
    }
}
