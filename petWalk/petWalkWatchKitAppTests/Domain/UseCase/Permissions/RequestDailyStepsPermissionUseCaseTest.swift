//
//  RequestDailyStepsPermissionUseCaseTest.swift
//  petWalkWatchKitAppTests
//
//  Created by Galera, Javier on 17/2/22.
//

import XCTest
@testable import petWalkWatchKitApp

class RequestDailyStepsPermissionUseCaseTest: XCTestCase {
    private var sut: RequestDailyStepsPermissionUseCase!
    private var repository: HealthStoreRepositoryMock!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        repository = HealthStoreRepositoryMock()
        sut = RequestDailyStepsPermissionUseCaseImplementation(healthStoreRepository: repository)
    }

    func testThatPermissionIsRequestedProperly_When_ExecuteIsCalled() async throws {
        repository.requestAuthorizationReturnValue = true
        
        let permission = try! await sut.execute()
        
        XCTAssertTrue(permission)
        XCTAssertEqual(1, self.repository.requestAuthorizationCallsCount)
    }
}
