//
//  HealthDataSourceTest.swift
//  petWalkWatchKitAppTests
//
//  Created by Galera, Javier on 17/2/22.
//

import XCTest
import HealthKit
@testable import petWalkWatchKitExtension

class HealthDataSourceTest: XCTestCase {
    var sut: HealthStoreDataSource!
    var healthStoreMock: HKHealthStore!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        healthStoreMock = HKHealthStore()
        sut = HealthStoreDataSourceImplementation(healthStore: healthStoreMock)
    }
    
    func testThatHealthStoreHasPermission_When_RequestAuthorizationIsSuccesful() async throws {
        let permission = try! await sut.requestAuthorization()
        
        XCTAssertTrue(permission)
    }
}
