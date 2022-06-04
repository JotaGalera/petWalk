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
    private var savePreviousAnimationProgressUseCaseMock: SavePreviousAnimationProgressUseCaseMock!
    private var getStepsUseCaseMock: GetStepsUseCaseMock!
    private var getAccumulatedDailyStepsUseCaseMock: GetAccumulatedDailyStepsUseCaseMock!
    private var getPreviousAnimationProgressUseCaseMock: GetPreviousAnimationProgressUseCaseMock!
    private var expToRaiseNextLevel: Int!
    
    @MainActor override func setUpWithError() throws {
        try super.setUpWithError()
        
        trackingManagerMock = TrackingManagerMock()
        saveAccumulateDailyStepsUseCaseMock = SaveAccumulatedDailyStepsUseCaseMock()
        saveTotalStepsUseCaseMock = SaveTotalStepsUseCaseMock()
        savePreviousAnimationProgressUseCaseMock = SavePreviousAnimationProgressUseCaseMock()
        getStepsUseCaseMock = GetStepsUseCaseMock()
        getAccumulatedDailyStepsUseCaseMock = GetAccumulatedDailyStepsUseCaseMock()
        getPreviousAnimationProgressUseCaseMock = GetPreviousAnimationProgressUseCaseMock()
        expToRaiseNextLevel = 100
        
        sut = PetDataViewModel(trackingManager: trackingManagerMock,
                               saveAccumulatedDailyStepsUseCase: saveAccumulateDailyStepsUseCaseMock,
                               saveTotalStepsUseCase: saveTotalStepsUseCaseMock,
                               savePreviousAnimationProgressUseCase: savePreviousAnimationProgressUseCaseMock,
                               getStepsUseCase: getStepsUseCaseMock,
                               getAccumulatedDailyStepsUseCase: getAccumulatedDailyStepsUseCaseMock,
                               getPreviousAnimationProgressUseCase: getPreviousAnimationProgressUseCaseMock,
                               expToRaiseNextLevel: expToRaiseNextLevel)
    }
    
    func testThatStepsAreNotRequested_When_TrackingDailyStepsIsNotGranted() async throws {
        trackingManagerMock.isTrackingDailyStepsEnabledReturnValue = false
        
        await sut.getSteps()
        
        XCTAssertEqual(0, getStepsUseCaseMock.executeCallsCount)
    }
    
    func testThatGetStepsUseCaseIsCalled_When_TrackingDailyStepsIsGranted() async throws {
        trackingManagerMock.isTrackingDailyStepsEnabledReturnValue = true
        getStepsUseCaseMock.executeReturnValue = 10
        getAccumulatedDailyStepsUseCaseMock.executeReturnValue = 10
        
        await sut.getSteps()
        
        XCTAssertEqual(1, getStepsUseCaseMock.executeCallsCount)
    }
    
    @MainActor func testThatStepsAreRequested_When_PermissionIsGranted() async throws {
        trackingManagerMock.isTrackingDailyStepsEnabledReturnValue = true
        getStepsUseCaseMock.executeReturnValue = 10
        getAccumulatedDailyStepsUseCaseMock.executeReturnValue = 0
        
        await sut.getSteps()
        
        XCTAssertEqual(10, sut.currentSteps)
    }
    
    @MainActor func testThatAnimationDailyStepsAreCalculated_When_TrackingDailyStepsIsGranted() async throws {
        trackingManagerMock.isTrackingDailyStepsEnabledReturnValue = true
        getStepsUseCaseMock.executeReturnValue = 50
        getAccumulatedDailyStepsUseCaseMock.executeReturnValue = 20
        
        await sut.getSteps()
        
        XCTAssertEqual(1, getAccumulatedDailyStepsUseCaseMock.executeCallsCount)
        XCTAssertEqual(30, sut.animationDailySteps)
    }
    
    @MainActor func testThatPreviousProgressAnimationIsObtained_When_GetPreviousProgressAnimationIsCalled() {
        getPreviousAnimationProgressUseCaseMock.executeReturnValue = 100
        
         sut.getPreviousProgressAnimation()
        
        XCTAssertEqual(100, sut.previousAnimationProgress)
    }
    
    @MainActor func testThatPreviousProgressAnimationIsSaved_When_SavePreviousProgressAnimationIsCalled() {
        let previousProgressMock = 10.0
        
        sut.savePreviousProgressAnimation(previousProgressMock)
        
        XCTAssertEqual(1, savePreviousAnimationProgressUseCaseMock.executeCallsCount)
        XCTAssertEqual(previousProgressMock, savePreviousAnimationProgressUseCaseMock.executeReceivedPreviousAnimationProgress)
    }
}
