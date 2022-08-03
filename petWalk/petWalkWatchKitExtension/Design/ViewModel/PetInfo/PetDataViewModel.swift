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
    @Published var hasPetRaisedANewLevel: Bool = false
    @Published var pet: Pets
    
    private var trackingManager: TrackingManager
    private var saveAccumulatedDailyStepsUseCase: SaveAccumulatedDailyStepsUseCase
    private var saveTotalStepsUseCase: SaveTotalStepsUseCase
    private var savePreviousAnimationProgressUseCase: SavePreviousAnimationProgressUseCase
    private var getStepsUseCase: GetStepsUseCase
    private var getAccumulatedDailyStepsUseCase: GetAccumulatedDailyStepsUseCase
    private var getPreviousAnimationProgressUseCase: GetPreviousAnimationProgressUseCase
    
    init(pet: Pets, trackingManager: TrackingManager, saveAccumulatedDailyStepsUseCase: SaveAccumulatedDailyStepsUseCase, saveTotalStepsUseCase: SaveTotalStepsUseCase, savePreviousAnimationProgressUseCase: SavePreviousAnimationProgressUseCase, getStepsUseCase: GetStepsUseCase, getAccumulatedDailyStepsUseCase: GetAccumulatedDailyStepsUseCase, getPreviousAnimationProgressUseCase: GetPreviousAnimationProgressUseCase) {
        self.pet = pet
        self.trackingManager = trackingManager
        self.saveAccumulatedDailyStepsUseCase = saveAccumulatedDailyStepsUseCase
        self.saveTotalStepsUseCase = saveTotalStepsUseCase
        self.savePreviousAnimationProgressUseCase = savePreviousAnimationProgressUseCase
        self.getStepsUseCase = getStepsUseCase
        self.getAccumulatedDailyStepsUseCase = getAccumulatedDailyStepsUseCase
        self.getPreviousAnimationProgressUseCase = getPreviousAnimationProgressUseCase
    }
    
    func getSteps() async {
        guard trackingManager.isTrackingDailyStepsEnabled() else {
            return
        }
        
        do {
            let steps = try await getStepsUseCase.execute()
            feedingPet(steps)
            saveAccumulatedDailyStepsUseCase.execute(steps)
            saveTotalStepsUseCase.execute(steps)
            currentSteps = steps
        } catch {
            print (error)
        }
        
    }
    
    func feedingPet(_ steps: Int) {
        if  steps >= pet.level.expToLevelUp {
            let leftoverSteps = steps - pet.level.expToLevelUp
            pet.levelUp()
            hasPetRaisedANewLevel = true
            feedingPet(leftoverSteps)
        } else {
            hasPetRaisedANewLevel = false
            calculateAnimationDailySteps(steps)
        }
    }
    
    private func calculateAnimationDailySteps(_ steps: Int) {
        let previousSteps = self.getAccumulatedDailyStepsUseCase.execute()
        self.animationDailySteps = steps - previousSteps
    }
    
    func getPreviousProgressAnimation() {
        previousAnimationProgress = getPreviousAnimationProgressUseCase.execute()
    }
    
    func savePreviousProgressAnimation(_ previousAnimationProgress: Double) {
        savePreviousAnimationProgressUseCase.execute(previousAnimationProgress)
    }
}
