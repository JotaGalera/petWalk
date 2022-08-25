//
//  SetupPetRolViewModel.swift
//  petWalkWatchKitExtension
//
//  Created by Galera, Javier on 20/8/22.
//

import Foundation

class SetupPetRolViewModel: ObservableObject {
    @Published var rolIndex = 0
    private var roles: [Rol] = [Swordman(), Ninja(), Wizard()]
    private let savePetRolUseCase: SavePetRolUseCase
    
    init(savePetRolUseCase: SavePetRolUseCase) {
        self.savePetRolUseCase = savePetRolUseCase
    }
    
    func showNextRol() {
        rolIndex = (rolIndex + 1) % 3
    }
    
    func showPreviousRol() {
        rolIndex = (rolIndex + 2) % 3
    }
    
    func showRolImages() -> [String] {
        return roles[rolIndex].images
    }
    
    func savePetRol() {
        let rol = roles[rolIndex].classname
        savePetRolUseCase.execute(rol)
    }
}
