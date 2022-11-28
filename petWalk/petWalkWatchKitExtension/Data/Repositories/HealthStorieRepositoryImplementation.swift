//
//  HealthStorieRepositoryImplementation.swift
//  petWalkWatchKitExtension
//
//  Created by Galera, Javier on 28/11/22.
//
import Combine
import Foundation

class HealthStoreRepositoryImplementation: HealthStoreRepository {
    private var dataSource: HealthStoreDataSource
    
    public init(dataSource: HealthStoreDataSource) {
        self.dataSource = dataSource
    }

    func requestAuthorization() async throws -> Bool {
        return try await dataSource.requestAuthorization()
    }
    
    func getSteps(date: Date) async throws -> Int {
        return try await dataSource.getSteps(date: date)
    }
}
