//
//  PetDataViewModel.swift
//  petWalkWatchKitExtension
//
//  Created by Galera, Javier on 17/3/22.
//

import Foundation

class PetDataViewModel: ObservableObject {
    @Published var animationDailySteps: Int = 0
    
    private var getAccumulatedDailyStepsUseCase: GetAccumulatedDailyStepsUseCase
    
    init(getAccumulatedDailyStepsUseCase: GetAccumulatedDailyStepsUseCase) {
        self.getAccumulatedDailyStepsUseCase = getAccumulatedDailyStepsUseCase
    }
    
    func calculateAnimationDailySteps(_ steps: Int) {
        let accumulatedDailySteps = self.getAccumulatedDailyStepsUseCase.execute()
        self.animationDailySteps = steps - accumulatedDailySteps
    }
}
