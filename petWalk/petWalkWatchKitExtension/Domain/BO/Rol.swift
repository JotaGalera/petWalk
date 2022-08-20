//
//  Rol.swift
//  petWalkWatchKitExtension
//
//  Created by Galera, Javier on 15/8/22.
//

protocol Rol: AutoMockable {
    var classname: String { get }
    var images: [String] { get }
}

struct Swordman: Rol {
    var classname: String = "Swordman"
    var images = ["run1",
                  "run2",
                  "run3",
                  "run4",
                  "run5",
                  "run6",
                  "run7",
                  "run8"]
}

struct Ninja: Rol {
    var classname: String = "Ninja"
    var images: [String] = ["NinjaRun1",
                            "NinjaRun2",
                            "NinjaRun3",
                            "NinjaRun4",
                            "NinjaRun5",
                            "NinjaRun6",
                            "NinjaRun7",
                            "NinjaRun8"]
}

struct Wizard: Rol {
    var classname: String = "Wizard"
    var images: [String] = ["WizardRun1",
                            "WizardRun2",
                            "WizardRun3",
                            "WizardRun4",
                            "WizardRun5",
                            "WizardRun6",
                            "WizardRun7",
                            "WizardRun8"]
}
