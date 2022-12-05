//
//  SetPetRolUseCase.swift
//  petWalk
//
//  Created by Galera, Javier on 5/12/22.
//

import Foundation

protocol SetPetRolUseCase: AutoMockable {
    func execute(rol: String)
}

class SetPetRolUseCaseImplementation: SetPetRolUseCase {
    private let repository: UserDefaultsRepository
    
    init(repository: UserDefaultsRepository) {
        self.repository = repository
    }
    
    func execute(rol: String) {
        repository.setPetRol(rol: rol)
    }
}
