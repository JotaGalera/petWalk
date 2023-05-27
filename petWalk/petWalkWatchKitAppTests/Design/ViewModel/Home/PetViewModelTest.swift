//
//  PetViewModelTest.swift
//  petWalkWatchKitAppTests
//
//  Created by Galera, Javier on 17/2/22.
//

import XCTest
@testable import petWalkWatchKitApp

class PetViewModelTest: XCTestCase {
    private var sut: PetViewModel!
    private var requestDailyStepsPermissionUseCaseMock: RequestDailyStepsPermissionUseCaseMock!
    private var saveTrackingDailyStepsUseCase: SaveTrackingDailyStepsUseCaseMock!
    private var getPetDataUseCase: GetPetDataUseCaseMock!
    
    @MainActor override func setUpWithError() throws {
        try super.setUpWithError()
        
        requestDailyStepsPermissionUseCaseMock = RequestDailyStepsPermissionUseCaseMock()
        saveTrackingDailyStepsUseCase = SaveTrackingDailyStepsUseCaseMock()
        getPetDataUseCase = GetPetDataUseCaseMock()
        
        let petMock = Pet(name: "nameMock", rol: Swordman(), level: Level())
        getPetDataUseCase.executeReturnValue = petMock
        
        sut = PetViewModel(requestDailyStepsPermissionUseCase: requestDailyStepsPermissionUseCaseMock,
                           saveTrackingDailyStepsUseCase: saveTrackingDailyStepsUseCase,
                           getPetDataUseCase: getPetDataUseCase)
    }

    func testThatTrackingDailyStepsIsRequested_When_RequestPermissionIsCalled() async {
        requestDailyStepsPermissionUseCaseMock.executeReturnValue = true
        
        await sut.requestPermissions()
        
        XCTAssertEqual(1, requestDailyStepsPermissionUseCaseMock.executeCallsCount)
        XCTAssertEqual(1, saveTrackingDailyStepsUseCase.executeCallsCount)
    }
    
    @MainActor func testThatPetIsReturned_When_PetViewModelHasBeenInitialized() {
        let petMock = Pet(name: "nameMock", rol: Swordman(), level: Level())
        
        XCTAssertEqual(petMock, sut.pet as! Pet)
    }
}
