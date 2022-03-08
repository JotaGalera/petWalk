//
//  HealthStore.swift
//  petWalk WatchKit Extension
//
//  Created by Galera, Javier on 9/1/22.
//

import Foundation
import HealthKit
import Combine

protocol HealthStoreDataSource: AutoMockable {
    func requestAuthorization() async throws -> Bool
    func getDailySteps() async throws -> Int
}

class HealthStoreDataSourceImplementation: HealthStoreDataSource {
    private var healthStore: HKHealthStore?
    
    init(healthStore: HKHealthStore = HKHealthStore()) {
        if HKHealthStore.isHealthDataAvailable() {
            self.healthStore = healthStore
        }
    }
    
    func requestAuthorization() async throws -> Bool {
        try await withCheckedThrowingContinuation { continuation in
            let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
            
            guard let healthStore = healthStore else { return continuation.resume(returning: false) }
            
            healthStore.requestAuthorization(toShare: [], read: [stepType]) { success, error in
                continuation.resume(returning: success)
            }
        }
    }
    
    func getDailySteps() async throws -> Int {
        try await withCheckedThrowingContinuation { continuation in
            let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
            
            let now = Date()
            let startOfDay = Calendar.current.startOfDay(for: now)
            let predicate = HKQuery.predicateForSamples(withStart: startOfDay,
                                                        end: now,
                                                        options: .strictStartDate)
            
            let query = HKStatisticsQuery(quantityType: stepType,
                                          quantitySamplePredicate: predicate,
                                          options: .cumulativeSum) { _, result, _ in
                guard let result = result, let sum = result.sumQuantity() else {
                    continuation.resume(returning: 0)
                    return
                }
                let steps = Int(sum.doubleValue(for: HKUnit.count()))
                continuation.resume(returning: steps)
            }
            
            healthStore?.execute(query)
        }
    }
}
