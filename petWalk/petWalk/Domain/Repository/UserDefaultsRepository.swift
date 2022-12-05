//
//  UserDefaultsRepository.swift
//  petWalk
//
//  Created by Galera, Javier on 28/11/22.
//

import Foundation

protocol UserDefaultsRepository: AutoMockable {
    func setPetName(name: String)
    func getPetName() -> String
    func getPetLevel() -> Int
    func setPetRol(rol: String)
    func getPetRol() -> String
}
