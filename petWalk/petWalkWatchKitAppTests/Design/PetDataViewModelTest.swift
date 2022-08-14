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
    private var petMock: PetsMock!
    private var trackingManagerMock: TrackingManagerMock!
    private var saveAccumulateDailyStepsUseCaseMock: SaveAccumulatedDailyStepsUseCaseMock!
    private var saveTotalStepsUseCaseMock : SaveTotalStepsUseCaseMock!
    private var savePreviousAnimationProgressUseCaseMock: SavePreviousAnimationProgressUseCaseMock!
    private var savePetLevelUseCaseMock: SavePetLevelUseCaseMock!
    private var getStepsUseCaseMock: GetStepsUseCaseMock!
    private var getAccumulatedDailyStepsUseCaseMock: GetAccumulatedDailyStepsUseCaseMock!
    private var getPreviousAnimationProgressUseCaseMock: GetPreviousAnimationProgressUseCaseMock!
    private var expToRaiseNextLevel: Int!
    
    @MainActor override func setUpWithError() throws {
        try super.setUpWithError()
        
        petMock = PetsMock()
        petMock.level = Level()
        petMock.stats = Stats(currentLevel: 1)
        petMock.name = "PetMock"
        
        trackingManagerMock = TrackingManagerMock()
        saveAccumulateDailyStepsUseCaseMock = SaveAccumulatedDailyStepsUseCaseMock()
        saveTotalStepsUseCaseMock = SaveTotalStepsUseCaseMock()
        savePreviousAnimationProgressUseCaseMock = SavePreviousAnimationProgressUseCaseMock()
        savePetLevelUseCaseMock = SavePetLevelUseCaseMock()
        getStepsUseCaseMock = GetStepsUseCaseMock()
        getAccumulatedDailyStepsUseCaseMock = GetAccumulatedDailyStepsUseCaseMock()
        getPreviousAnimationProgressUseCaseMock = GetPreviousAnimationProgressUseCaseMock()
        
        
        sut = PetDataViewModel(pet: petMock,
            trackingManager: trackingManagerMock,
                               saveAccumulatedDailyStepsUseCase: saveAccumulateDailyStepsUseCaseMock,
                               saveTotalStepsUseCase: saveTotalStepsUseCaseMock,
                               savePreviousAnimationProgressUseCase: savePreviousAnimationProgressUseCaseMock,
                               savePetLevelUseCase: savePetLevelUseCaseMock,
                               getStepsUseCase: getStepsUseCaseMock,
                               getAccumulatedDailyStepsUseCase: getAccumulatedDailyStepsUseCaseMock,
                               getPreviousAnimationProgressUseCase: getPreviousAnimationProgressUseCaseMock)
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
    
    func testThatAccumulatedDailyStepsAreSaved_When_GetStepsIsCalled() async throws {
        let stepsMock = 10
        trackingManagerMock.isTrackingDailyStepsEnabledReturnValue = true
        getStepsUseCaseMock.executeReturnValue = stepsMock
        getAccumulatedDailyStepsUseCaseMock.executeReturnValue = 0
        
        await sut.getSteps()
        
        XCTAssertEqual(1, saveAccumulateDailyStepsUseCaseMock.executeCallsCount)
        XCTAssertEqual(stepsMock, saveAccumulateDailyStepsUseCaseMock.executeReceivedSteps)
    }
    
    func testThatTotalStepsAreSaved_When_GetStepsIsCalled() async throws {
        let stepsMock = 10
        trackingManagerMock.isTrackingDailyStepsEnabledReturnValue = true
        getStepsUseCaseMock.executeReturnValue = stepsMock
        getAccumulatedDailyStepsUseCaseMock.executeReturnValue = 0
        
        await sut.getSteps()
        
        XCTAssertEqual(1, saveTotalStepsUseCaseMock.executeCallsCount)
        XCTAssertEqual(stepsMock, saveTotalStepsUseCaseMock.executeReceivedSteps)
    }
    
    @MainActor func testThatAnimationIsDisplayed_When_PetHasRaisedANewLevel() async throws {
        let stepsMock = 1000
        trackingManagerMock.isTrackingDailyStepsEnabledReturnValue = true
        getStepsUseCaseMock.executeReturnValue = stepsMock
        getAccumulatedDailyStepsUseCaseMock.executeReturnValue = 0
        
        await sut.getSteps()
        
        XCTAssertTrue(sut.hasPetRaisedANewLevel)
    }
    
    @MainActor func testThatPetLevelUpIsCalled_When_PetHasRaisedNewLevel() async throws {
        let stepsMock = 1000
        trackingManagerMock.isTrackingDailyStepsEnabledReturnValue = true
        getStepsUseCaseMock.executeReturnValue = stepsMock
        getAccumulatedDailyStepsUseCaseMock.executeReturnValue = 0
        
        await sut.getSteps()
        
        XCTAssertTrue(petMock.levelUpCalled)
    }
    
    @MainActor func testThatPetLevelIsSaved_When_PetHasRaisedANewLevel() async throws {
        let stepsMock = 301
        trackingManagerMock.isTrackingDailyStepsEnabledReturnValue = true
        getStepsUseCaseMock.executeReturnValue = stepsMock
        getAccumulatedDailyStepsUseCaseMock.executeReturnValue = 0
        
        await sut.getSteps()
        
        XCTAssertEqual(1, savePetLevelUseCaseMock.executeCallsCount)
    }
    
    @MainActor func testThatPetLevelUpIsCalledAsManyTimesAsLevelsAreRaisedByPet() async throws {
        let stepsMock = 1000
        trackingManagerMock.isTrackingDailyStepsEnabledReturnValue = true
        getStepsUseCaseMock.executeReturnValue = stepsMock
        getAccumulatedDailyStepsUseCaseMock.executeReturnValue = 0
        
        await sut.getSteps()
        
        XCTAssertEqual(3, petMock.levelUpCallsCount)
    }
    
    @MainActor func testThatAnimationIsNotDisplayed_When_PetHasNoRaisedANewLevel() async throws {
        let stepsMock = 10
        trackingManagerMock.isTrackingDailyStepsEnabledReturnValue = true
        getStepsUseCaseMock.executeReturnValue = stepsMock
        getAccumulatedDailyStepsUseCaseMock.executeReturnValue = 0
        
        await sut.getSteps()
        
        XCTAssertFalse(sut.hasPetRaisedANewLevel)
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
