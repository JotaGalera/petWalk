//
//  ContentViewModel.swift
//  petWalk WatchKit Extension
//
//  Created by Galera, Javier on 9/1/22.
//

import Foundation

class ContentViewModel: ObservableObject {
    @Published var currentSteps: Int = 0
    
    private var requestDailyStepsPermissionUseCase: RequestDailyStepsPermissionUseCase
    private var saveDailyStepsUseCase: SaveDailyStepsUseCase
    private var getDailyStepsUseCase: GetDailyStepsUseCase
    
    init(requestDailyStepsPermissionUseCase: RequestDailyStepsPermissionUseCase, saveDailyStepsUseCase: SaveDailyStepsUseCase, getDailyStepsUseCase: GetDailyStepsUseCase) {
        self.requestDailyStepsPermissionUseCase = requestDailyStepsPermissionUseCase
        self.saveDailyStepsUseCase = saveDailyStepsUseCase
        self.getDailyStepsUseCase = getDailyStepsUseCase
        
        getDailyStepsUseCase.getTodaySteps { steps in
            self.saveDailyStepsUseCase.saveDailySteps(steps)
            self.currentSteps = steps
        }
    }
    
    func requestPermissions() {
        requestDailyStepsPermissionUseCase.execute { authorization in
            if authorization {
                self.getDailyStepsUseCase.getTodaySteps { steps in
                    self.currentSteps = steps
                    self.saveDailyStepsUseCase.saveDailySteps(steps)
                }
            }
        }
    }
}
