//
//  SetPetRolUseCaseTests.swift
//  petWalkTests
//
//  Created by Galera, Javier on 5/12/22.
//
@testable import petWalk
import XCTest

class SetPetRolUseCaseTests: XCTestCase {
    private var sut: SetPetRolUseCaseImplementation!
    private var repository: UserDefaultsRepositoryMock!
    
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        repository = UserDefaultsRepositoryMock()
        sut = SetPetRolUseCaseImplementation(repository: repository)
    }
    
    func testThatPetRolIsSaved_When_ExecuteIsCalled() throws {
        sut.execute(rol: "rolMock")
        
        XCTAssertEqual(1, repository.setPetRolRolCallsCount)
    }
}
