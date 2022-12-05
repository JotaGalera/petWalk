//
//  SetPetNameUseCase.swift
//  petWalk
//
//  Created by Galera, Javier on 5/12/22.
//

import Foundation

protocol SetPetNameUseCase: AutoMockable {
    func execute(name: String)
}

class SetPetNameUseCaseImplementation: SetPetNameUseCase {
    private let repository: UserDefaultsRepository
    
    init(repository: UserDefaultsRepository) {
        self.repository = repository
    }
    
    func execute(name: String) {
        repository.setPetName(name: name)
    }
}
