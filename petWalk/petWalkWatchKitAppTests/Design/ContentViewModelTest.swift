//
//  ContentViewModelTest.swift
//  petWalkWatchKitAppTests
//
//  Created by Galera, Javier on 17/2/22.
//

import XCTest
@testable import petWalkWatchKitExtension

class ContentViewModelTest: XCTestCase {
    private var sut: PetViewModel!
    private var requestDailyStepsPermissionUseCaseMock: RequestDailyStepsPermissionUseCaseMock!
    private var saveDailyStepsUseCaseMock: SaveAccumulatedDailyStepsUseCaseMock!
    private var saveTotalDailyStepsUseCaseMock : SaveTotalStepsUseCaseMock!
    private var getDailyStepsUseCaseMock: GetDailyStepsUseCaseMock!
    private var getAccumulatedDailyStepsUseCase: GetAccumulatedDailyStepsUseCaseMock!
    
    @MainActor override func setUpWithError() throws {
        try super.setUpWithError()
        
        requestDailyStepsPermissionUseCaseMock = RequestDailyStepsPermissionUseCaseMock()
        saveDailyStepsUseCaseMock = SaveAccumulatedDailyStepsUseCaseMock()
        saveTotalDailyStepsUseCaseMock = SaveTotalStepsUseCaseMock()
        getDailyStepsUseCaseMock = GetDailyStepsUseCaseMock()
        getAccumulatedDailyStepsUseCase = GetAccumulatedDailyStepsUseCaseMock()
        
        sut = PetViewModel(requestDailyStepsPermissionUseCase: requestDailyStepsPermissionUseCaseMock,
                           saveAccumulatedDailyStepsUseCase: saveDailyStepsUseCaseMock,
                               saveTotalDailyStepsUseCase: saveTotalDailyStepsUseCaseMock,
                               getDailyStepsUseCase: getDailyStepsUseCaseMock,
                               getAccumulatedDailyStepsUseCase: getAccumulatedDailyStepsUseCase)
    }

    @MainActor func testThatDailyStepsAreRequested_When_PermissionIsGranted() async throws {
        requestDailyStepsPermissionUseCaseMock.executeReturnValue = true
        getDailyStepsUseCaseMock.executeReturnValue = 10
        getAccumulatedDailyStepsUseCase.executeReturnValue = 0
        
        await sut.requestPermissions()
        
        XCTAssertEqual(1, requestDailyStepsPermissionUseCaseMock.executeCallsCount)
        XCTAssertEqual(1, getDailyStepsUseCaseMock.executeCallsCount)
        XCTAssertEqual(1, saveDailyStepsUseCaseMock.executeCallsCount)
        XCTAssertEqual(10, sut.currentSteps)
    }
    
    @MainActor func testThatAnimationDailyStepsAreUpdated_When_PermissionIsGranted_And_ThereArePreviousSteps() async throws {
        requestDailyStepsPermissionUseCaseMock.executeReturnValue = true
        getDailyStepsUseCaseMock.executeReturnValue = 50
        getAccumulatedDailyStepsUseCase.executeReturnValue = 20
        
        await sut.requestPermissions()
        
        XCTAssertEqual(30, sut.animationDailySteps)
    }
}
