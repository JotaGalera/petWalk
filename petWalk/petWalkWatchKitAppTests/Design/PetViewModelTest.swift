//
//  PetViewModelTest.swift
//  petWalkWatchKitAppTests
//
//  Created by Galera, Javier on 17/2/22.
//

import XCTest
@testable import petWalkWatchKitExtension

class PetViewModelTest: XCTestCase {
    private var sut: PetViewModel!
    private var requestDailyStepsPermissionUseCaseMock: RequestDailyStepsPermissionUseCaseMock!
    private var saveTrackingDailyStepsUseCase: SaveTrackingDailyStepsUseCaseMock!
    
    @MainActor override func setUpWithError() throws {
        try super.setUpWithError()
        
        requestDailyStepsPermissionUseCaseMock = RequestDailyStepsPermissionUseCaseMock()
        saveTrackingDailyStepsUseCase = SaveTrackingDailyStepsUseCaseMock()
        
        sut = PetViewModel(requestDailyStepsPermissionUseCase: requestDailyStepsPermissionUseCaseMock,
                           saveTrackingDailyStepsUseCase: saveTrackingDailyStepsUseCase)
    }

    func testThatTrackingDailyStepsIsRequested_When_RequestPermissionIsCalled() async {
        requestDailyStepsPermissionUseCaseMock.executeReturnValue = true
        
        await sut.requestPermissions()
        
        XCTAssertEqual(1, requestDailyStepsPermissionUseCaseMock.executeCallsCount)
    }
}
