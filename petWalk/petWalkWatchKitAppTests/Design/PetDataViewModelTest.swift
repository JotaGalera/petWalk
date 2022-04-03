//
//  PetDataViewModelTest.swift
//  petWalkWatchKitAppTests
//
//  Created by Galera, Javier on 3/4/22.
//

import XCTest
@testable import petWalkWatchKitExtension

class PetDataViewModelTest: XCTestCase {
    private var sut: PetDataViewModel!
    private var trackingManagerMock: TrackingManagerMock!
    private var saveAccumulateDailyStepsUseCaseMock: SaveAccumulatedDailyStepsUseCaseMock!
    private var saveTotalStepsUseCaseMock : SaveTotalStepsUseCaseMock!
    private var getDailyStepsUseCaseMock: GetDailyStepsUseCaseMock!
    private var getAccumulatedDailyStepsUseCaseMock: GetAccumulatedDailyStepsUseCaseMock!
    
    @MainActor override func setUpWithError() throws {
        try super.setUpWithError()
        
        trackingManagerMock = TrackingManagerMock()
        saveAccumulateDailyStepsUseCaseMock = SaveAccumulatedDailyStepsUseCaseMock()
        saveTotalStepsUseCaseMock = SaveTotalStepsUseCaseMock()
        getDailyStepsUseCaseMock = GetDailyStepsUseCaseMock()
        getAccumulatedDailyStepsUseCaseMock = GetAccumulatedDailyStepsUseCaseMock()
        
        sut = PetDataViewModel(trackingManager: trackingManagerMock,
                               saveAccumulatedDailyStepsUseCase: saveAccumulateDailyStepsUseCaseMock,
                               saveTotalStepsUseCase: saveTotalStepsUseCaseMock,
                               getDailyStepsUseCase: getDailyStepsUseCaseMock,
                               getAccumulatedDailyStepsUseCase: getAccumulatedDailyStepsUseCaseMock)
    }
    
    func testThatDailyStepsAreNotRequested_When_TrackingDailySetepsIsNotGranted() async throws {
        trackingManagerMock.isTrackingDailyStepsEnabledReturnValue = false
        
        await sut.getDailySteps()
        
        XCTAssertEqual(0, getDailyStepsUseCaseMock.executeCallsCount)
    }
    
    func testThatGetDailyStepsUseCaseIsCalled_When_TrackingDailyStepsIsGranted() async throws {
        trackingManagerMock.isTrackingDailyStepsEnabledReturnValue = true
        getDailyStepsUseCaseMock.executeReturnValue = 10
        getAccumulatedDailyStepsUseCaseMock.executeReturnValue = 10
        
        await sut.getDailySteps()
        
        XCTAssertEqual(1, getDailyStepsUseCaseMock.executeCallsCount)
    }
    
    @MainActor func testThatDailyStepsAreRequested_When_PermissionIsGranted() async throws {
        trackingManagerMock.isTrackingDailyStepsEnabledReturnValue = true
        getDailyStepsUseCaseMock.executeReturnValue = 10
        getAccumulatedDailyStepsUseCaseMock.executeReturnValue = 0
        
        await sut.getDailySteps()
        
        XCTAssertEqual(10, sut.currentSteps)
    }
    
    @MainActor func testThatAnimationDailyStepsAreCalculated_When_TrackingDailyStepsIsGranted() async throws {
        trackingManagerMock.isTrackingDailyStepsEnabledReturnValue = true
        getDailyStepsUseCaseMock.executeReturnValue = 50
        getAccumulatedDailyStepsUseCaseMock.executeReturnValue = 20
        
        await sut.getDailySteps()
        
        XCTAssertEqual(1, getAccumulatedDailyStepsUseCaseMock.executeCallsCount)
        XCTAssertEqual(30, sut.animationDailySteps)
    }
}
