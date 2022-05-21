//
//  GetAccumulatedDailyStepsUseCase.swift
//  petWalkWatchKitExtension
//
//  Created by Galera, Javier on 28/2/22.
//

import Foundation

protocol GetAccumulatedDailyStepsUseCase: AutoMockable {
    func execute() -> Int
}

class GetAccumulatedDailyStepsUseCaseImplementation: GetAccumulatedDailyStepsUseCase {
    private var repository: UserDefaultsRepository
    
    init(repository: UserDefaultsRepository) {
        self.repository = repository
    }
    
    func execute() -> Int {
        if areDailySteps() {
            return repository.getAccumulatedDailySteps()
        } else {
            return 0
        }
    }
    
    private func areDailySteps() -> Bool {
        let calendar = NSCalendar.current
        
        let date1 = calendar.startOfDay(for: Date.now)
        let date2 = calendar.startOfDay(for: repository.getDateDailySteps())
        
        let daysBetweenDates = calendar.dateComponents([.day], from: date1, to: date2).day
        
        return daysBetweenDates == 0
    }
}


