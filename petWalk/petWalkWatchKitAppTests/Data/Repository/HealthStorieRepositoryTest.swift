//
//  HealthStorieRepositoryTest.swift
//  petWalkWatchKitAppTests
//
//  Created by Galera, Javier on 17/2/22.
//

import XCTest
@testable import petWalkWatchKitExtension

class HealthStorieRepositoryTest: XCTestCase {
    private var sut: HealthStoreRepository!
    private var dataSourceMock: HealthStoreDataSourceMock!
    
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        dataSourceMock = HealthStoreDataSourceMock()
        sut = HealthStoreRepositoryImplementation(dataSource: dataSourceMock)
    }

    func testThatAuthorizationHasBeenRequestedProperly_When_RequestAuthorizationIsCalled() async throws {
        dataSourceMock.requestAuthorizationReturnValue = true
        
        let permission = try! await sut.requestAuthorization()
        
        XCTAssertEqual(1, self.dataSourceMock.requestAuthorizationCallsCount)
        XCTAssertTrue(permission)
    }
    
    func testThatDailyStepsAreCollected_When_GetTodayStepsIsCalled() async throws {
        dataSourceMock.getDailyStepsReturnValue = 10
        
        let steps = try! await sut.getDailySteps()
        
        XCTAssertEqual(1, self.dataSourceMock.getDailyStepsCallsCount)
        XCTAssertEqual(10, steps)
    }
}
