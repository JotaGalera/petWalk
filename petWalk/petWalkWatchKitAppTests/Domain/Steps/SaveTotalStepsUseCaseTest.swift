//
//  SaveTotalStepsUseCaseTest.swift
//  petWalkWatchKitAppTests
//
//  Created by Galera, Javier on 2/3/22.
//

import XCTest
@testable import petWalkWatchKitExtension

class SaveTotalStepsUseCaseTest: XCTestCase {
    private var sut: SaveTotalStepsUseCase!
    private var repository: UserDefaultsRepositoryMock!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        repository = UserDefaultsRepositoryMock()
        
        sut = SaveTotalStepsUseCaseImplementation(repository: repository)
    }

    func testThatTotalStepsAreSavedOnMemory_When_ExecuteIsCalled() {
        let stepsMocked = 10
        repository.getTotalStepsReturnValue = 10
        
        sut.execute(stepsMocked)
        
        XCTAssertEqual(1, repository.saveTotalStepsCallsCount)
        XCTAssertEqual(20, repository.saveTotalStepsReceivedSteps)
    }
}
