//
//  GetDailyStepsUseCaseTest.swift
//  petWalkWatchKitAppTests
//
//  Created by Galera, Javier on 17/2/22.
//

import XCTest
@testable import petWalkWatchKitExtension

class GetDailyStepsUseCaseTest: XCTestCase {
    private var sut: GetDailyStepsUseCase!
    private var repository: HealthStoreRepositoryMock!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        repository = HealthStoreRepositoryMock()
        sut = GetDailyStepsUseCaseImplementation(healthStoreRepository: repository)
    }

    func testThatDailyStepsAreReturned_When_ExecuteIsCalled() throws {
        let expectation = expectation(description: "Getting daily steps")
        repository.getDailyStepsCompletionClosure = { onSuccess in
            onSuccess(10)
        }
        
        sut.execute { steps in
            XCTAssertEqual(10, steps)
            XCTAssertEqual(1, self.repository.getDailyStepsCompletionCallsCount)
            expectation.fulfill()
        }
        
        waitForExpectation(timeOut: 3)
    }
}
