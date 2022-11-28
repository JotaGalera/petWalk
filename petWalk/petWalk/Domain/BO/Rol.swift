//
//  Rol.swift
//  petWalk
//
//  Created by Galera, Javier on 23/11/22.
//

fileprivate enum Roles: String {
    case swordman = "Swordman"
    case ninja = "Ninja"
    case wizard = "Wizard"
}

protocol Rol: AutoMockable {
    var classname: String { get }
    var images: [String] { get }
}

struct RolFactory {
    static func make(_ rolName: String) -> Rol? {
        switch rolName {
        case Roles.swordman.rawValue:
            return Swordman()
        case Roles.ninja.rawValue:
            return Ninja()
        case Roles.wizard.rawValue:
            return Wizard()
        default:
            return nil
        }
    }
}

struct Swordman: Rol {
    let classname = Roles.swordman.rawValue
    let images = ["run1",
                  "run2",
                  "run3",
                  "run4",
                  "run5",
                  "run6",
                  "run7",
                  "run8"]
}

struct Ninja: Rol {
    let classname = Roles.ninja.rawValue
    let images: [String] = ["NinjaRun1",
                            "NinjaRun2",
                            "NinjaRun3",
                            "NinjaRun4",
                            "NinjaRun5",
                            "NinjaRun6",
                            "NinjaRun7",
                            "NinjaRun8"]
}

struct Wizard: Rol {
    let classname = Roles.wizard.rawValue
    let images: [String] = ["WizardRun1",
                            "WizardRun2",
                            "WizardRun3",
                            "WizardRun4",
                            "WizardRun5",
                            "WizardRun6",
                            "WizardRun7",
                            "WizardRun8"]
}
