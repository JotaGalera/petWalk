//
//  SetupPetRolViewModelTest.swift
//  petWalkWatchKitAppTests
//
//  Created by Galera, Javier on 20/8/22.
//

import XCTest
@testable import petWalkWatchKitExtension

class SetupPetRolViewModelTest: XCTestCase {
    var sut: SetupPetRolViewModel!
    var savePetRolUseCaseMock: SavePetRolUseCaseMock!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        savePetRolUseCaseMock = SavePetRolUseCaseMock()
        sut = SetupPetRolViewModel(savePetRolUseCase: savePetRolUseCaseMock)
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
}
