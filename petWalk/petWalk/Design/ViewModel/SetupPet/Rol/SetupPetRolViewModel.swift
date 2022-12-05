//
//  SetupPetRolViewModel.swift
//  petWalk
//
//  Created by Galera, Javier on 3/11/22.
//

import Foundation

class SetupPetRolViewModel: ObservableObject {
    @Published var continueWithNextView: Bool = false
    @Published var rolIndex = 0
    private var roles: [Rol] = [Swordman(), Ninja(), Wizard()]
    
    private let getPetDataUseCase: GetPetDataUseCase
    private let setPetRolUseCase: SetPetRolUseCase
    
    init(getPetDataUseCase: GetPetDataUseCase, setPetRolUseCase: SetPetRolUseCase) {
        self.getPetDataUseCase = getPetDataUseCase
        self.setPetRolUseCase = setPetRolUseCase
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
    
    func canContinueWithNextView() -> Bool {
        guard let _ = getPetDataUseCase.execute() else {
            return false
        }
        return true
    }
    
    func savePetRol() {
        let rol = roles[rolIndex].classname
        setPetRolUseCase.execute(rol: rol)
    }
}
