//
//  ContentViewModel.swift
//  petWalk WatchKit Extension
//
//  Created by Galera, Javier on 9/1/22.
//

import Foundation

class ContentViewModel: ObservableObject {
    @Published var currentSteps: Double = 0
    var healthStore: HealthStore
    
    init(healthStore: HealthStore) {
        self.healthStore = healthStore
        
        healthStore.getTodaysSteps { steps in
            self.currentSteps = steps
        }
    }
    
    func requestPermissions() {
        healthStore.requestAuthorization { request in
            if request {
                self.healthStore.getTodaysSteps { steps in
                    self.currentSteps = steps
                }
            }
        }
    }
}
