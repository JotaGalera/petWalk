//
//  SetupPetRolViewModel.swift
//  petWalk
//
//  Created by Galera, Javier on 3/11/22.
//

import Foundation

class SetupPetRolViewModel: ObservableObject {
    @Published var rolIndex = 0
    private var swordman = Swordman().images
    private var ninja = Ninja().images
    private var wizard: [String] = Wizard().images
    private var roles: [[String]]
    
    init() {
        roles = [swordman, ninja, wizard]
    }
    
    func showNextRol() {
        rolIndex = (rolIndex + 1) % 3
    }
    
    func showPreviousRol() {
        rolIndex = (rolIndex + 2) % 3
    }
    
    func showRolImages() -> [String] {
        return roles[rolIndex]
    }
}
