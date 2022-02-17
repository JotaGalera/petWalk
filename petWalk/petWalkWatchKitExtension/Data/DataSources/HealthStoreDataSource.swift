//
//  HealthStore.swift
//  petWalk WatchKit Extension
//
//  Created by Galera, Javier on 9/1/22.
//

import Foundation
import HealthKit

protocol HealthStoreDataSource: AutoMockable {
    func requestAuthorization(completion: @escaping (Bool) -> Void)
    func getTodaySteps(completion: @escaping (Int) -> Void)
}

class HealthStoreDataSourceImplementation: HealthStoreDataSource {
    private var healthStore: HKHealthStore?
    
    init(healthStore: HKHealthStore = HKHealthStore()) {
        if HKHealthStore.isHealthDataAvailable() {
            self.healthStore = healthStore
        }
    }
    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        
        guard let healthStore = healthStore else { return completion(false) }
        
        healthStore.requestAuthorization(toShare: [], read: [stepType]) { success, error in
            completion(success)
        }
    }
    
    func getTodaySteps(completion: @escaping (Int) -> Void) {
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
                completion(0)
                return
            }
            let steps = Int(sum.doubleValue(for: HKUnit.count()))
            completion(steps)
        }
        
        healthStore?.execute(query)
    }
}
