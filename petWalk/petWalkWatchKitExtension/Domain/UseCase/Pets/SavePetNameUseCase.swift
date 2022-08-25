//
//  SavePetNameUseCase.swift
//  petWalkWatchKitExtension
//
//  Created by Galera, Javier on 11/6/22.
//

import Foundation

protocol SavePetNameUseCase: AutoMockable {
    func execute(_ name: String)
}

class SavePetNameUseCaseImplementation: SavePetNameUseCase {
    private let repository: UserDefaultsRepository
    
    init(repository: UserDefaultsRepository) {
        self.repository = repository
    }
    
    func execute(_ name: String) {
        repository.savePetName(name)
    }
}
