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
        let pet = buildPet(petName: petName)
        return pet
    }
    
    private func buildPet(petName: String) -> Pets {
        let petLevel = Level()
        let petStats = Stats()
        return Swordman(name: petName, level: petLevel, stats: petStats)
    }
}
