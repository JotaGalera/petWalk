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
        
        getDailyStepsUseCase.execute { steps in
            self.saveDailyStepsUseCase.execute(steps)
            self.currentSteps = steps
        }
    }
    
    func requestPermissions() {
        requestDailyStepsPermissionUseCase.execute { authorization in
            if authorization {
                self.getDailyStepsUseCase.execute { steps in
                    DispatchQueue.main.async {
                        self.currentSteps = steps
                    }
                    self.saveDailyStepsUseCase.execute(steps)
                }
            }
        }
    }
}
