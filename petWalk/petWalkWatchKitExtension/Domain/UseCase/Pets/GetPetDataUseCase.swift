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
    private let petMock = Swordman(name: "Beldrick", level: Level(), stats: Stats())
    
    func execute() -> Pets {
        return petMock
    }
}
