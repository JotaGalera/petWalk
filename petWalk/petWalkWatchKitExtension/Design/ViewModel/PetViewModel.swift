//
//  ContentViewModel.swift
//  petWalk WatchKit Extension
//
//  Created by Galera, Javier on 9/1/22.
//

import Foundation

@MainActor
class PetViewModel: ObservableObject {
    @Published var currentSteps: Int = 0
    var animationDailySteps: Int = 0
    
    private var requestDailyStepsPermissionUseCase: RequestDailyStepsPermissionUseCase
    private var saveAccumulatedDailyStepsUseCase: SaveAccumulatedDailyStepsUseCase
    private var saveTotalDailyStepsUseCase: SaveTotalStepsUseCase
    private var getDailyStepsUseCase: GetDailyStepsUseCase
    private var getAccumulatedDailyStepsUseCase: GetAccumulatedDailyStepsUseCase
    
    init(requestDailyStepsPermissionUseCase: RequestDailyStepsPermissionUseCase, saveAccumulatedDailyStepsUseCase: SaveAccumulatedDailyStepsUseCase, saveTotalDailyStepsUseCase: SaveTotalStepsUseCase, getDailyStepsUseCase: GetDailyStepsUseCase, getAccumulatedDailyStepsUseCase: GetAccumulatedDailyStepsUseCase) {
        self.requestDailyStepsPermissionUseCase = requestDailyStepsPermissionUseCase
        self.saveAccumulatedDailyStepsUseCase = saveAccumulatedDailyStepsUseCase
        self.saveTotalDailyStepsUseCase = saveTotalDailyStepsUseCase
        self.getDailyStepsUseCase = getDailyStepsUseCase
        self.getAccumulatedDailyStepsUseCase = getAccumulatedDailyStepsUseCase
    }
    
    func requestPermissions() async {
        do {
            let permission = try await requestDailyStepsPermissionUseCase.execute()
            if permission {
                try await getDailySteps()
            }
            // TODO: Manage no permission
        } catch {
            print (error)
        }
    }
    
    func getDailySteps() async throws { // TODO: Probably this should be on PetDataViewModel
        let steps = try await getDailyStepsUseCase.execute()
        calculateAnimationDailySteps(steps)
        saveAccumulatedDailyStepsUseCase.execute(steps)
        saveTotalDailyStepsUseCase.execute(steps)
        currentSteps = steps
    }
    
    private func calculateAnimationDailySteps(_ steps: Int) {
        let accumulatedDailySteps = self.getAccumulatedDailyStepsUseCase.execute()
        self.animationDailySteps = steps - accumulatedDailySteps
    }
}
