//
//  SetupPetViewModelTest.swift
//  petWalkWatchKitAppTests
//
//  Created by Galera, Javier on 25/6/22.
//
@testable import petWalkWatchKitExtension
import XCTest

class SetupPetViewModelTest: XCTestCase {
    private var sut: SetupPetViewModel!
    private var getPetDataUseCaseMock: GetPetDataUseCaseMock!
    
    @MainActor override func setUpWithError() throws {
        try super.setUpWithError()
        
        getPetDataUseCaseMock = GetPetDataUseCaseMock()
        sut = SetupPetViewModel(getPetDataUseCase: getPetDataUseCaseMock)
    }
    
    @MainActor func testThatHasPetNameIsTrue_When_PetHasName() {
        getPetDataUseCaseMock.executeReturnValue = Swordman(name: "nameMock", level: Level(), stats: Stats())
        
        sut.checkPetHasName()
        
        XCTAssertTrue(sut.hasPetName)
    }
    
    @MainActor func testThatHasPetNameIsFalse_When_PetDoesNotHaveName() {
        getPetDataUseCaseMock.executeReturnValue = Swordman(name: "", level: Level(), stats: Stats())
        
        sut.checkPetHasName()
        
        XCTAssertFalse(sut.hasPetName)
    }
}
