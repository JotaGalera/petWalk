//
//  SetupPetRolViewModelTests.swift
//  petWalkTests
//
//  Created by Galera, Javier on 28/11/22.
//
@testable import petWalk
import XCTest

class SetupPetRolViewModelTests: XCTestCase {
    private var sut: SetupPetRolViewModel!
    private var getPetDataUseCaseMock: GetPetDataUseCaseMock!
    private var setPetRolUseCaseMock: SetPetRolUseCaseMock!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        getPetDataUseCaseMock = GetPetDataUseCaseMock()
        setPetRolUseCaseMock = SetPetRolUseCaseMock()
        sut = SetupPetRolViewModel(getPetDataUseCase: getPetDataUseCaseMock, setPetRolUseCase: setPetRolUseCaseMock)
    }

    func testThatIndexIsNextOne_When_ShowNextRolIsCalled() throws {
        sut.showNextRol()
        
        XCTAssertEqual(1, sut.rolIndex)
    }

    func testThatIndexIsNotPointingInvalidSection_When_ShowNextRolIsCalledThreeTimes() {
        sut.showNextRol()
        sut.showNextRol()
        sut.showNextRol()
        
        XCTAssertEqual(0, sut.rolIndex)
    }
    
    func testThatIndexIsPreviousOne_When_ShowPreviousRolIsCalled() throws {
        sut.rolIndex = 1
        
        sut.showPreviousRol()
        
        XCTAssertEqual(0, sut.rolIndex)
    }
    
    func testThatIndexIsNotPointingInvalidSection_When_ShowPreviousRolIsCalled_And_IndexIsInTheFirstPostion() {
        sut.showPreviousRol()
        
        XCTAssertEqual(2, sut.rolIndex)
    }
    
    func testThatPetImagesAreReturned_When_ShowRolImagesIsCalled() {
        let images = sut.showRolImages()
        
        XCTAssertEqual(Swordman().images, images)
    }
}
