//
//  ContentViewModel.swift
//  petWalk WatchKit Extension
//
//  Created by Galera, Javier on 9/1/22.
//

import Foundation

@MainActor
class PetViewModel: ObservableObject {
    private var requestDailyStepsPermissionUseCase: RequestDailyStepsPermissionUseCase
    private var saveTrackingDailyStepsUseCase: SaveTrackingDailyStepsUseCase
    
    init(requestDailyStepsPermissionUseCase: RequestDailyStepsPermissionUseCase, saveTrackingDailyStepsUseCase: SaveTrackingDailyStepsUseCase) {
        self.requestDailyStepsPermissionUseCase = requestDailyStepsPermissionUseCase
        self.saveTrackingDailyStepsUseCase = saveTrackingDailyStepsUseCase
    }
    
    func requestPermissions() async {
        do {
            let permission = try await requestDailyStepsPermissionUseCase.execute()
            if permission {
                saveTrackingDailyStepsUseCase.execute(permission)
            }
            // TODO: Manage no permission
        } catch {
            print (error)
        }
    }
}
