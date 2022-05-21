//
//  GetPreviousAnimationProgressUseCase.swift
//  petWalkWatchKitExtension
//
//  Created by Galera, Javier on 21/5/22.
//

import Foundation

protocol GetPreviousAnimationProgressUseCase: AutoMockable {
    func execute() -> Double
}

class GetPreviousAnimationProgressUseCaseImplementation: GetPreviousAnimationProgressUseCase {
    private var repository: UserDefaultsRepository
    
    public init(repository: UserDefaultsRepository) {
        self.repository = repository
    }

    func execute() -> Double {
        return repository.getPreviousAnimationProgress()
    }
}
