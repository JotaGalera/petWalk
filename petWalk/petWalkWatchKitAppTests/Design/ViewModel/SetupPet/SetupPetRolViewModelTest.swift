//
//  SetupPetRolViewModelTest.swift
//  petWalkWatchKitAppTests
//
//  Created by Galera, Javier on 20/8/22.
//

import XCTest
@testable import petWalkWatchKitApp

class SetupPetRolViewModelTest: XCTestCase {
    var sut: SetupPetRolViewModel!
    var savePetRolUseCaseMock: SavePetRolUseCaseMock!
    var getPetDataUseCaseMock: GetPetDataUseCaseMock!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        savePetRolUseCaseMock = SavePetRolUseCaseMock()
        getPetDataUseCaseMock = GetPetDataUseCaseMock()
        sut = SetupPetRolViewModel(savePetRolUseCase: savePetRolUseCaseMock, getPetDataUseCase: getPetDataUseCaseMock)
    }
    
    func testThatRolIndexIsPointingToNextPosition_When_ShowNextRolIsCalled() {
        sut.showNextRol()
        
        XCTAssertEqual(1, sut.rolIndex)
    }
    
    func testThatRolIndexIsPointingToFirsPosition_When_ShowNextRolIsCalledThreeTimes() {
        sut.showNextRol()
        sut.showNextRol()
        sut.showNextRol()
        
        XCTAssertEqual(0, sut.rolIndex)
    }
    
    func testThatRolIndexIsPointingToPreviousPosition_When_ShowPreviosRolIsCalled() {
        sut.rolIndex = 1
        
        sut.showPreviousRol()
        
        XCTAssertEqual(0, sut.rolIndex)
    }
    
    func testThatRolIndexIsPointingToLastPositon_When_ShowPreviousRollIsCalled_And_RolIndexIsZero() {
        sut.showPreviousRol()
        
        XCTAssertEqual(2, sut.rolIndex)
    }
    
    func testThatRolImagesAreReturnedProperly_When_ShowRolImagesIsCalled() {
        sut.showNextRol()
        
        let images = sut.showRolImages()
        
        XCTAssertEqual(["NinjaRun1",
                        "NinjaRun2",
                        "NinjaRun3",
                        "NinjaRun4",
                        "NinjaRun5",
                        "NinjaRun6",
                        "NinjaRun7",
                        "NinjaRun8"], images)
    }
    
    func testThatPetRolIsSaved_When_SavePetRolIsCalled() {
        sut.savePetRol()
        
        XCTAssertEqual(1, savePetRolUseCaseMock.executeCallsCount)
    }
    
    func testThatItCanContinueToNextView_When_PetHasARol() {
        let petMock = PetsMock()
        petMock.rol = Swordman()
        getPetDataUseCaseMock.executeReturnValue = petMock
        
        let result = sut.canContinueWithNextView()
        
        XCTAssertTrue(result)
        XCTAssertEqual(1, getPetDataUseCaseMock.executeCallsCount)
    }
    
    func testThatItCannotContinueToNextView_When_PetHasARol() {
        let petMock = PetsMock()
        petMock.rol = nil
        getPetDataUseCaseMock.executeReturnValue = petMock
        
        let result = sut.canContinueWithNextView()
        
        XCTAssertFalse(result)
        XCTAssertEqual(1, getPetDataUseCaseMock.executeCallsCount)
    }
}
