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

    func testThatDailyStepsAndDateAreSavedOnMemory_When_ExecuteIsCalled() {
        let stepsMocked = 10
        
        sut.execute(stepsMocked)
        
        XCTAssertEqual(1, repository.saveDailyStepsCallsCount)
        XCTAssertEqual(10, repository.saveDailyStepsReceivedSteps)
        XCTAssertEqual(1, repository.saveDateDailyStepsCallsCount)
        XCTAssertGreaterThanOrEqual(Date(), repository.saveDateDailyStepsReceivedDate!)
    }
}
