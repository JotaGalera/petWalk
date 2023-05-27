//
//  GetAccumulatedDailyStepsUseCase.swift
//  petWalkWatchKitExtension
//
//  Created by Galera, Javier on 28/2/22.
//

import Foundation

public protocol GetAccumulatedDailyStepsUseCase: AutoMockable {
    func execute() -> Int
}

class GetAccumulatedDailyStepsUseCaseImplementation: GetAccumulatedDailyStepsUseCase {
    private var repository: UserDefaultsRepository
    
    init(repository: UserDefaultsRepository) {
        self.repository = repository
    }
    
    func execute() -> Int {
        let lastTimeAppWasOpened = repository.getDateDailySteps()
        
        if lastTimeAppWasOpened.isToday() {
            return repository.getAccumulatedDailySteps()
        } else {
            return 0
        }
    }
}




