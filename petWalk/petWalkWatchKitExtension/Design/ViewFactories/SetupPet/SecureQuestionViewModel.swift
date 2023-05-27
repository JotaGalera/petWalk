//
//  SecureQuestionViewModel.swift
//  petWalkWatchKitExtension
//
//  Created by Galera, Javier on 11/6/22.
//

import Foundation

@MainActor
class SecureQuestionViewModel: ObservableObject {
    @Published var hasPetName: Bool = false
    private let savePetNameUseCase: SavePetNameUseCase
    private let savePetRolUseCase: SavePetRolUseCase
    
    init(savePetNameUseCase: SavePetNameUseCase, savePetRolUseCase: SavePetRolUseCase) {
        self.savePetNameUseCase = savePetNameUseCase
        self.savePetRolUseCase = savePetRolUseCase
    }
    
    func savePetName(_ name: String) {
        savePetNameUseCase.execute(name)
    }
    
    func removePetRol() {
        savePetRolUseCase.execute("")
    }
}
