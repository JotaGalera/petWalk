//
//  SetupPetViewModel.swift
//  petWalkWatchKitExtension
//
//  Created by Galera, Javier on 21/6/22.
//

import Foundation

@MainActor
class SetupPetViewModel: ObservableObject {
    @Published var hasPetName: Bool = false
    var getPetDataUseCase: GetPetDataUseCase
    
    init(getPetDataUseCase: GetPetDataUseCase) {
        self.getPetDataUseCase = getPetDataUseCase
    }
    
    func checkPetHasName() {
        hasPetName = getPetDataUseCase.execute().name != ""
    }
}
