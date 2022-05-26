//
//  PetDataViewModel.swift
//  petWalkWatchKitExtension
//
//  Created by Galera, Javier on 17/3/22.
//

import Foundation

@MainActor
class PetDataViewModel: ObservableObject {
    @Published var currentSteps: Int = 0
    @Published var animationDailySteps: Int = 0
    @Published var previousAnimationProgress: Double = 0
    @Published var levelUpExp: Int = 1000
    
    private var trackingManager: TrackingManager
    private var saveAccumulatedDailyStepsUseCase: SaveAccumulatedDailyStepsUseCase
    private var saveTotalStepsUseCase: SaveTotalStepsUseCase
    private var savePreviousAnimationProgressUseCase: SavePreviousAnimationProgressUseCase
    private var getDailyStepsUseCase: GetDailyStepsUseCase
    private var getAccumulatedDailyStepsUseCase: GetAccumulatedDailyStepsUseCase
    private var getPreviousAnimationProgressUseCase: GetPreviousAnimationProgressUseCase
    
    init(trackingManager: TrackingManager, saveAccumulatedDailyStepsUseCase: SaveAccumulatedDailyStepsUseCase, saveTotalStepsUseCase: SaveTotalStepsUseCase, savePreviousAnimationProgressUseCase: SavePreviousAnimationProgressUseCase, getDailyStepsUseCase: GetDailyStepsUseCase, getAccumulatedDailyStepsUseCase: GetAccumulatedDailyStepsUseCase, getPreviousAnimationProgressUseCase: GetPreviousAnimationProgressUseCase) {
        self.trackingManager = trackingManager
        self.saveAccumulatedDailyStepsUseCase = saveAccumulatedDailyStepsUseCase
        self.saveTotalStepsUseCase = saveTotalStepsUseCase
        self.savePreviousAnimationProgressUseCase = savePreviousAnimationProgressUseCase
        self.getDailyStepsUseCase = getDailyStepsUseCase
        self.getAccumulatedDailyStepsUseCase = getAccumulatedDailyStepsUseCase
        self.getPreviousAnimationProgressUseCase = getPreviousAnimationProgressUseCase
    }
    
    func getDailySteps() async {
        guard trackingManager.isTrackingDailyStepsEnabled() else {
            return
        }
        
        do {
            let steps = try await getDailyStepsUseCase.execute()
            calculateAnimationDailySteps(steps)
            saveAccumulatedDailyStepsUseCase.execute(steps)
            saveTotalStepsUseCase.execute(steps)
            currentSteps = steps
        } catch {
            print (error)
        }
        
    }
    
    func calculateAnimationDailySteps(_ steps: Int) {
        let accumulatedDailySteps = self.getAccumulatedDailyStepsUseCase.execute()
        self.animationDailySteps = steps - accumulatedDailySteps
    }
    
    func getPreviousProgressAnimation() {
        previousAnimationProgress = getPreviousAnimationProgressUseCase.execute()
    }
    
    func savePreviousProgressAnimation(_ previousAnimationProgress: Double) {
        savePreviousAnimationProgressUseCase.execute(previousAnimationProgress)
    }
}
