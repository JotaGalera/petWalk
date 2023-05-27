//
//  SaveTrackingDailyStepsUseCaseTest.swift
//  petWalkWatchKitAppTests
//
//  Created by Galera, Javier on 3/4/22.
//

import XCTest
@testable import petWalkWatchKitApp

class SaveTrackingDailyStepsUseCaseTest: XCTestCase {
    private var sut: SaveTrackingDailyStepsUseCase!
    private var userDefaultRepository: UserDefaultsRepositoryMock!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        userDefaultRepository = UserDefaultsRepositoryMock()
        sut = SaveTrackingDailyStepsUseCaseImplementation(userDefaultRepository: userDefaultRepository)
    }
    
    func testThatTrackingDailyStepsPermissionIsSavedOnMemory_When_ExecuteIsCalled() {
        let permission = true
        
        sut.execute(permission)
        
        XCTAssertEqual(1, userDefaultRepository.saveTrackingDailyStepsCallsCount)
    }
}
