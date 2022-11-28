//
//  GetPetDataUseCaseTests.swift
//  petWalkTests
//
//  Created by Galera, Javier on 28/11/22.
//
@testable import petWalk
import XCTest

class GetPetDataUseCaseTests: XCTestCase {
    private var sut: GetPetDataUseCaseImplementation!
    private var repository: UserDefaultsRepositoryMock!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        repository = UserDefaultsRepositoryMock()
        
        sut = GetPetDataUseCaseImplementation(repository: repository)
    }

    func testThatPetDataIsReceived_When_ExecuteIsCalled() throws {
        repository.getPetNameReturnValue = "petNameMock"
        repository.getPetLevelReturnValue = 2
        repository.getPetRolReturnValue = "Swordman"
        
        let petMock = sut.execute()
        
        XCTAssertEqual("petNameMock", petMock?.name)
        XCTAssertEqual(2, petMock?.getCurrentLevel())
        XCTAssertEqual("Swordman", petMock?.rol.classname)
    }

    func testThatPetIsNil_When_ThereIsNotARolStored() throws {
        repository.getPetNameReturnValue = "petNameMock"
        repository.getPetLevelReturnValue = 2
        repository.getPetRolReturnValue = ""
        
        let petMock = sut.execute()
        
        XCTAssertNil(petMock)
    }

}
