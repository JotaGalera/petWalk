//
//  RequestDailyStepsPermissionUseCaseTest.swift
//  petWalkWatchKitAppTests
//
//  Created by Galera, Javier on 17/2/22.
//

import XCTest
@testable import petWalkWatchKitExtension

class RequestDailyStepsPermissionUseCaseTest: XCTestCase {
    private var sut: RequestDailyStepsPermissionUseCase!
    private var repository: HealthStoreRepositoryMock!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        repository = HealthStoreRepositoryMock()
        sut = RequestDailyStepsPermissionUseCaseImplementation(healthStoreRepository: repository)
    }

    func testThatPermissionIsRequestedProperly_When_ExecuteIsCalled() throws {
        let expectation = expectation(description: "permission requested")
        repository.requestAuthorizationCompletionClosure = { onSuccess in
            onSuccess(true)
        }
        
        sut.execute { permission in
            XCTAssertTrue(permission)
            XCTAssertEqual(1, self.repository.requestAuthorizationCompletionCallsCount)
            expectation.fulfill()
        }
        
        waitForExpectation(timeOut: 3)
    }
}
