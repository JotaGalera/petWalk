//
//  SaveTotalStepsUseCase.swift
//  petWalkWatchKitExtension
//
//  Created by Galera, Javier on 28/2/22.
//

import Foundation

public protocol SaveTotalStepsUseCase: AutoMockable {
    func execute(_ steps: Int)
}

class SaveTotalStepsUseCaseImplementation: SaveTotalStepsUseCase {
    private var repository: UserDefaultsRepository
    
    public init(repository: UserDefaultsRepository) {
        self.repository = repository
    }
    
    func execute(_ steps: Int) {
        let previousDailySteps = repository.getTotalSteps()
        
        repository.saveTotalSteps(steps + previousDailySteps)
    }
}
