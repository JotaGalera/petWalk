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

    func testThatDailyStepsAreReturned_When_ExecuteIsCalled() async throws {
        repository.getDailyStepsReturnValue = 10
        
        let dailySteps = try! await sut.execute()
        
        XCTAssertEqual(10, dailySteps)
        XCTAssertEqual(1, self.repository.getDailyStepsCallsCount)
    }
}
