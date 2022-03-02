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

    func testThatAuthorizationHasBeenRequestedProperly_When_RequestAuthorizationIsCalled() throws {
        let expectation = expectation(description: "Requesting permission")
        dataSourceMock.requestAuthorizationCompletionClosure = { onSuccess in
            onSuccess(true)
        }
        
        sut.requestAuthorization { permission in
            XCTAssertEqual(1, self.dataSourceMock.requestAuthorizationCompletionCallsCount)
            XCTAssertTrue(permission)
            expectation.fulfill()
        }
        
        waitForExpectation(timeOut: 3)
    }
    
    func testThatDailyStepsAreCollected_When_GetTodayStepsIsCalled() {
        let expectation = expectation(description: "Getting steps")
        dataSourceMock.getDailyStepsCompletionClosure = { onSuccess in
            onSuccess(10)
        }
        
        sut.getDailySteps { steps in
            XCTAssertEqual(1, self.dataSourceMock.getDailyStepsCompletionCallsCount)
            XCTAssertEqual(10, steps)
            expectation.fulfill()
        }
        
        waitForExpectation(timeOut: 3)
    }
}
