//
//  ContentViewModel.swift
//  petWalk WatchKit Extension
//
//  Created by Galera, Javier on 9/1/22.
//

import Foundation

class ContentViewModel: ObservableObject {
    @Published var currentSteps: Int = 0
    var animationDailySteps: Int = 0
    
    private var requestDailyStepsPermissionUseCase: RequestDailyStepsPermissionUseCase
    private var saveDailyStepsUseCase: SaveDailyStepsUseCase
    private var saveTotalDailyStepsUseCase: SaveTotalStepsUseCase
    private var getDailyStepsUseCase: GetDailyStepsUseCase
    private var getAccumulatedDailyStepsUseCase: GetAccumulatedDailyStepsUseCase
    
    init(requestDailyStepsPermissionUseCase: RequestDailyStepsPermissionUseCase, saveDailyStepsUseCase: SaveDailyStepsUseCase, saveTotalDailyStepsUseCase: SaveTotalStepsUseCase, getDailyStepsUseCase: GetDailyStepsUseCase, getAccumulatedDailyStepsUseCase: GetAccumulatedDailyStepsUseCase) {
        self.requestDailyStepsPermissionUseCase = requestDailyStepsPermissionUseCase
        self.saveDailyStepsUseCase = saveDailyStepsUseCase
        self.saveTotalDailyStepsUseCase = saveTotalDailyStepsUseCase
        self.getDailyStepsUseCase = getDailyStepsUseCase
        self.getAccumulatedDailyStepsUseCase = getAccumulatedDailyStepsUseCase
    }
    
    func requestPermissions() {
        requestDailyStepsPermissionUseCase.execute { authorization in
            if authorization {
                self.getDailySteps()
            }
        }
    }
    
    func getDailySteps() {
        getDailyStepsUseCase.execute { steps in
            self.calculateAnimationDailySteps(steps)
            
            self.saveDailyStepsUseCase.execute(steps)
            DispatchQueue.main.async {
                self.currentSteps = steps
            }
            
            self.saveTotalDailyStepsUseCase.execute(steps)
        }
    }
    
    private func calculateAnimationDailySteps(_ steps: Int) {
        let accumulatedDailySteps = self.getAccumulatedDailyStepsUseCase.execute()
        self.animationDailySteps = steps - accumulatedDailySteps
    }
}
