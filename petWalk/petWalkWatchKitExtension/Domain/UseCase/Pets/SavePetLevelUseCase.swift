//
//  SavePetLevelUseCase.swift
//  petWalkWatchKitExtension
//
//  Created by Galera, Javier on 3/8/22.
//

protocol SavePetLevelUseCase: AutoMockable {
    func execute(_ level: Int)
}

class SavePetLevelUseCaseImplementation: SavePetLevelUseCase {
    private let repository: UserDefaultsRepository
    
    init(repository: UserDefaultsRepository) {
        self.repository = repository
    }
    
    func execute(_ level: Int) {
        repository.savePetLevel(level)
    }
}
