//
//  HealthStore.swift
//  petWalk WatchKit Extension
//
//  Created by Galera, Javier on 9/1/22.
//

import Foundation
import HealthKit
import Combine

public protocol HealthStoreDataSource: AutoMockable {
    func requestAuthorization() async throws -> Bool
    func getSteps(date: Date) async throws -> Int
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
            
            guard let healthStore = healthStore else {
                continuation.resume(returning: false)
                return
            }
            
            healthStore.requestAuthorization(toShare: [], read: [stepType]) { success, error in
                if let error = error {
                    continuation.resume(throwing: error)
                }
                continuation.resume(returning: success)
            }
        }
    }
    
    func getSteps(date: Date) async throws -> Int {
        try await withCheckedThrowingContinuation { continuation in
            let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
            
            let startOfDay = Calendar.current.startOfDay(for: date)
            let predicate = HKQuery.predicateForSamples(withStart: startOfDay,
                                                        end: .now,
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
