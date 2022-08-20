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
    
    func showNextRol() {
        rolIndex = (rolIndex + 1) % 3
    }
    
    func showPreviousRol() {
        rolIndex = (rolIndex + 2) % 3
    }
    
    func showRolImages() -> [String] {
        return roles[rolIndex].images
    }
}
