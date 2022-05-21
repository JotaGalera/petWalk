//
//  SavePreviousProgressAnimationUseCase.swift
//  petWalkWatchKitExtension
//
//  Created by Galera, Javier on 21/5/22.
//

import Foundation

protocol SavePreviousAnimationProgressUseCase: AutoMockable {
    func execute(_ previousAnimationProgress: Double)
}

class SavePreviousAnimationProgressUseCaseImplementation: SavePreviousAnimationProgressUseCase {
    private var repository: UserDefaultsRepository
    
    public init(repository: UserDefaultsRepository) {
        self.repository = repository
    }
    
    func execute(_ previousAnimationProgress: Double) {
        
        repository.savePreviousAnimationProgress(previousAnimationProgress)
    }
}
