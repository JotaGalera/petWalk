//
//  SecureQuestionViewModelTest.swift
//  petWalkWatchKitAppTests
//
//  Created by Galera, Javier on 19/6/22.
//

@testable import petWalkWatchKitExtension
import XCTest

class SecureQuestionViewModelTest: XCTestCase {
    private var sut: SecureQuestionViewModel!
    private var savePetNameUseCaseMock: SavePetNameUseCaseMock!
    
    @MainActor override func setUpWithError() throws {
        try super.setUpWithError()
        
        savePetNameUseCaseMock = SavePetNameUseCaseMock()
        sut = SecureQuestionViewModel(savePetNameUseCase: savePetNameUseCaseMock)
    }
    
    @MainActor func testThatPetNameIsSaved_When_SavePetNameIsCalled() {
        let nameMock = "nameMock"
        
        sut.savePetName(nameMock)
        
        XCTAssertEqual(1, savePetNameUseCaseMock.executeCallsCount)
        XCTAssertEqual(nameMock, savePetNameUseCaseMock.executeReceivedName)
    }
}
