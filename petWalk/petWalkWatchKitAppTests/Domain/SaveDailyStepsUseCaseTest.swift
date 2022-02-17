//
//  SaveDailyStepsUseCaseTest.swift
//  petWalkWatchKitAppTests
//
//  Created by Galera, Javier on 17/2/22.
//

import XCTest
@testable import petWalkWatchKitExtension

class SaveDailyStepsUseCaseTest: XCTestCase {
    private var sut: SaveDailyStepsUseCase!
    private var repository: UserDefaultsRepositoryMock!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        repository = UserDefaultsRepositoryMock()
        sut = SaveDailyStepsUseCaseImplementation(repository: repository)
    }

    func testThatDailyStepsAreSavedOnMemory_When_ExecuteIsCalled() throws {
        let stepsMock = 10
        
        sut.execute(stepsMock)
        
        XCTAssertEqual(1, repository.saveDailyStepsCallsCount)
        XCTAssertEqual(10, repository.saveDailyStepsReceivedSteps)
    }
}
