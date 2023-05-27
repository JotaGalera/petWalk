//
//  SecureQuestionViewModelTest.swift
//  petWalkWatchKitAppTests
//
//  Created by Galera, Javier on 19/6/22.
//

@testable import petWalkWatchKitApp
import XCTest

class SecureQuestionViewModelTest: XCTestCase {
    private var sut: SecureQuestionViewModel!
    private var savePetNameUseCaseMock: SavePetNameUseCaseMock!
    private var savePetRolUseCaseMock: SavePetRolUseCaseMock!
    
    @MainActor override func setUpWithError() throws {
        try super.setUpWithError()
        
        savePetNameUseCaseMock = SavePetNameUseCaseMock()
        savePetRolUseCaseMock = SavePetRolUseCaseMock()
        sut = SecureQuestionViewModel(savePetNameUseCase: savePetNameUseCaseMock, savePetRolUseCase: savePetRolUseCaseMock)
    }
    
    @MainActor func testThatPetNameIsSaved_When_SavePetNameIsCalled() {
        let nameMock = "nameMock"
        
        sut.savePetName(nameMock)
        
        XCTAssertEqual(1, savePetNameUseCaseMock.executeCallsCount)
        XCTAssertEqual(nameMock, savePetNameUseCaseMock.executeReceivedName)
    }
    
    @MainActor func testThatPetRolIsRemoved_When_RemovePetRolIsCalled() {
        sut.removePetRol()
        
        XCTAssertEqual(1, savePetRolUseCaseMock.executeCallsCount)
        
    }
}
