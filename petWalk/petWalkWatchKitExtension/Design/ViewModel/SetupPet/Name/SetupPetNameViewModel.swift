//
//  SetupPetNameViewModel.swift
//  petWalkWatchKitExtension
//
//  Created by Galera, Javier on 21/6/22.
//

import Foundation

@MainActor
class SetupPetNameViewModel: ObservableObject {
    @Published var continueWithNextView: Bool = false
    private let getPetDataUseCase: GetPetDataUseCase
    
    init(getPetDataUseCase: GetPetDataUseCase) {
        self.getPetDataUseCase = getPetDataUseCase
    }
    
    func canContinueWithNextView() {
        continueWithNextView = getPetDataUseCase.execute().name != ""
    }
}
