//
//  SavePetRolUseCase.swift
//  petWalkWatchKitExtension
//
//  Created by Galera, Javier on 25/8/22.
//

import Foundation

protocol SavePetRolUseCase: AutoMockable {
    func execute(_ rol: String)
}

class SavePetRolUseCaseImplementation: SavePetRolUseCase {
    private let repository: UserDefaultsRepository
    
    init(repository: UserDefaultsRepository) {
        self.repository = repository
    }
    
    func execute(_ rol: String) {
        repository.savePetRol(rol)
    }
}
