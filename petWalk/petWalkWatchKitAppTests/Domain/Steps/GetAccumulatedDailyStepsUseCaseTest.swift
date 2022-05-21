//
//  GetAccumulatedDailyStepsUseCaseTest.swift
//  petWalkWatchKitAppTests
//
//  Created by Galera, Javier on 2/3/22.
//

import XCTest
@testable import petWalkWatchKitExtension

class GetAccumulatedDailyStepsUseCaseTests: XCTestCase {
    private var sut: GetAccumulatedDailyStepsUseCase!
    private var repository: UserDefaultsRepositoryMock!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        repository = UserDefaultsRepositoryMock()
        sut = GetAccumulatedDailyStepsUseCaseImplementation(repository: repository)
    }
    
    func testThatAccumulatedDailyStepsAreReturned_When_ExecuteIsCalled_And_TheRequestIsInTheSameDay() {
        repository.getDateDailyStepsReturnValue = Date.now
        repository.getAccumulatedDailyStepsReturnValue = 10
        
        let dailySteps = sut.execute()
        
        XCTAssertEqual(10, dailySteps)
        XCTAssertEqual(1, repository.getAccumulatedDailyStepsCallsCount)
    }
    
    func testThatAccumulatedDailyStepsAreNotReturned_When_ExecuteIsCalled_And_TheRequestIsNotInTheSameDay() {
        repository.getDateDailyStepsReturnValue = Date.distantPast
        repository.getAccumulatedDailyStepsReturnValue = 10
        
        let dailySteps = sut.execute()
        
        XCTAssertEqual(0, dailySteps)
        XCTAssertEqual(0, repository.getAccumulatedDailyStepsCallsCount)
    }
}
