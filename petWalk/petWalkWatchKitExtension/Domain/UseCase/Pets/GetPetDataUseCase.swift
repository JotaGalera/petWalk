//
//  GetPetDataUseCase.swift
//  petWalkWatchKitExtension
//
//  Created by Galera, Javier on 4/6/22.
//

import Foundation

protocol GetPetDataUseCase: AutoMockable {
    func execute() -> Pets
}

class GetPetDataUseCaseImplementation: GetPetDataUseCase {
    private let repository: UserDefaultsRepository
    
    init(repository: UserDefaultsRepository) {
        self.repository = repository
    }
    
    func execute() -> Pets {
        let petName = repository.getPetName()
        let petLevel = repository.getPetLevel()
        let pet = buildPet(petName: petName, petLevel: petLevel)
        return pet
    }
    
    private func buildPet(petName: String, petLevel: Int) -> Pets {
        let level = Level(currentLevel: petLevel)
        return Swordman(name: petName, level: level)
    }
}
