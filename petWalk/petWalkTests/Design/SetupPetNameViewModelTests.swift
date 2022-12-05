//
//  SetupPetNameViewModelTests.swift
//  petWalkTests
//
//  Created by Galera, Javier on 5/12/22.
//

@testable import petWalk
import XCTest

class SetupPetNameViewModelTests: XCTestCase {
    private var sut: SetupPetNameViewModel!
    private var getPetDataUseCaseMock: GetPetDataUseCaseMock!
    
    override func setUpWithError() throws {
        try super.setUpWithError()

        getPetDataUseCaseMock = GetPetDataUseCaseMock()
        sut = SetupPetNameViewModel(getPetDataUseCase: getPetDataUseCaseMock)
    }
    
    func testThatNextViewIsDisplayed_When_PetHasName() {
        getPetDataUseCaseMock.executeReturnValue = Pet(name: "mockName", rol: RolMock(), level: Level())
        
        let displayNextView = sut.canContinueWithNextView()
        
        XCTAssertEqual(1, getPetDataUseCaseMock.executeCallsCount)
        XCTAssertTrue(displayNextView)
    }
    
    func testThatNextViewIsNotDisplayed_When_PetHasNotName() {
        getPetDataUseCaseMock.executeReturnValue = Pet(name: "", rol: RolMock(), level: Level())
        
        let displayNextView = sut.canContinueWithNextView()
        
        XCTAssertEqual(1, getPetDataUseCaseMock.executeCallsCount)
        XCTAssertFalse(displayNextView)
    }
}
