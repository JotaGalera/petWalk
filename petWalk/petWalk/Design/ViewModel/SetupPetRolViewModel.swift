//
//  SetupPetRolViewModel.swift
//  petWalk
//
//  Created by Galera, Javier on 3/11/22.
//

import Foundation

class SetupPetRolViewModel: ObservableObject {
    @Published var rolIndex = 0
    private var swordman = ["run1",
                            "run2",
                            "run3",
                            "run4",
                            "run5",
                            "run6",
                            "run7",
                            "run8"]
    private var ninja: [String] = ["NinjaRun1",
                                    "NinjaRun2",
                                    "NinjaRun3",
                                    "NinjaRun4",
                                    "NinjaRun5",
                                    "NinjaRun6",
                                    "NinjaRun7",
                                    "NinjaRun8"]
    var wizard: [String] = ["WizardRun1",
                            "WizardRun2",
                            "WizardRun3",
                            "WizardRun4",
                            "WizardRun5",
                            "WizardRun6",
                            "WizardRun7",
                            "WizardRun8"]
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
