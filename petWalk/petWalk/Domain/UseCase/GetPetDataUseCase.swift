//
//  GetPetDataUseCase.swift
//  petWalk
//
//  Created by Galera, Javier on 28/11/22.
//

import Foundation

protocol GetPetDataUseCase: AutoMockable {
    func execute() -> Pets?
}

class GetPetDataUseCaseImplementation: GetPetDataUseCase {
    private let repository: UserDefaultsRepository
    
    init(repository: UserDefaultsRepository) {
        self.repository = repository
    }
    
    func execute() -> Pets? {
        let petName = repository.getPetName()
        let petLevel = repository.getPetLevel()
        let petRol = repository.getPetRol()
        let pet = buildPet(petName: petName, petLevel: petLevel, petRol: petRol)
        return pet
    }
    
    private func buildPet(petName: String, petLevel: Int, petRol: String) -> Pets? {
        guard let rol = RolFactory.make(petRol) else {
            return nil
        }
        let level = Level(currentLevel: petLevel)
        
        return Pet(name: petName, rol: rol, level: level)
    }
}
