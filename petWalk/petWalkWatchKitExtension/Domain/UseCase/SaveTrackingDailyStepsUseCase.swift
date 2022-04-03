//
//  SaveTrackingDailyStepsUseCase.swift
//  petWalkWatchKitExtension
//
//  Created by Galera, Javier on 3/4/22.
//

import Foundation

protocol SaveTrackingDailyStepsUseCase: AutoMockable {
    func execute(_ permission: Bool)
}

class SaveTrackingDailyStepsUseCaseImplementation: SaveTrackingDailyStepsUseCase {
    private let userDefaultRepository: UserDefaultsRepository
    
    init(userDefaultRepository: UserDefaultsRepository) {
        self.userDefaultRepository = userDefaultRepository
    }
    
    func execute(_ permission: Bool) {
        userDefaultRepository.saveTrackingDailySteps(permission)
    }
}
