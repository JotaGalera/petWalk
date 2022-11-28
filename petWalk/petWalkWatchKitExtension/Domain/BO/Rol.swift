//
//  Rol.swift
//  petWalkWatchKitExtension
//
//  Created by Galera, Javier on 15/8/22.
//

fileprivate enum Roles: String {
    case swordman = "Swordman"
    case ninja = "Ninja"
    case wizard = "Wizard"
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

protocol Rol: AutoMockable {
    var classname: String { get }
    var images: [String] { get }
}

struct Swordman: Rol {
    var classname: String = Roles.swordman.rawValue
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
    var classname: String = Roles.ninja.rawValue
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
    var classname: String = Roles.wizard.rawValue
    var images: [String] = ["WizardRun1",
                            "WizardRun2",
                            "WizardRun3",
                            "WizardRun4",
                            "WizardRun5",
                            "WizardRun6",
                            "WizardRun7",
                            "WizardRun8"]
}
