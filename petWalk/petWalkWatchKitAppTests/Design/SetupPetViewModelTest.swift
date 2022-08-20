//
//  SetupPetViewModelTest.swift
//  petWalkWatchKitAppTests
//
//  Created by Galera, Javier on 25/6/22.
//
@testable import petWalkWatchKitExtension
import XCTest

class SetupPetViewModelTest: XCTestCase {
    private var sut: SetupPetNameViewModel!
    private var getPetDataUseCaseMock: GetPetDataUseCaseMock!
    
    @MainActor override func setUpWithError() throws {
        try super.setUpWithError()
        
        getPetDataUseCaseMock = GetPetDataUseCaseMock()
        sut = SetupPetNameViewModel(getPetDataUseCase: getPetDataUseCaseMock)
    }
    
    @MainActor func testThatHasPetNameIsTrue_When_PetHasName() {
        getPetDataUseCaseMock.executeReturnValue = Pet(name: "nameMock", level: Level())
        
        sut.canContinueWithNextView()
        
        XCTAssertTrue(sut.continueWithNextView)
    }
    
    @MainActor func testThatHasPetNameIsFalse_When_PetDoesNotHaveName() {
        getPetDataUseCaseMock.executeReturnValue = Pet(name: "", level: Level())
        
        sut.canContinueWithNextView()
        
        XCTAssertFalse(sut.continueWithNextView)
    }
}
