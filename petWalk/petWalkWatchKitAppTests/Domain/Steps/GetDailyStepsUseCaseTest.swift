//
//  getStepsUseCaseTest.swift
//  petWalkWatchKitAppTests
//
//  Created by Galera, Javier on 17/2/22.
//

import XCTest
@testable import petWalkWatchKitExtension

class GetStepsUseCaseTest: XCTestCase {
    private var sut: GetStepsUseCase!
    private var healthStorerepository: HealthStoreRepositoryMock!
    private var userDefaultRepository: UserDefaultsRepositoryMock!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        healthStorerepository = HealthStoreRepositoryMock()
        userDefaultRepository = UserDefaultsRepositoryMock()
        sut = GetStepsUseCaseImplementation(healthStoreRepository: healthStorerepository, userDefaultRepository: userDefaultRepository)
    }

    func testThatStepsAreReturned_When_ExecuteIsCalled() async throws {
        healthStorerepository.getStepsDateReturnValue = 10
        userDefaultRepository.getDateDailyStepsReturnValue = Date.now
        
        let steps = try! await sut.execute()
        
        XCTAssertEqual(10, steps)
        XCTAssertEqual(1, self.healthStorerepository.getStepsDateCallsCount)
        XCTAssertEqual(1, self.userDefaultRepository.getDateDailyStepsCallsCount)
    }
}
