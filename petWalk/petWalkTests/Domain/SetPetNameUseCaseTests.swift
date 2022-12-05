//
//  SetPetNameUseCaseTests.swift
//  petWalkTests
//
//  Created by Galera, Javier on 5/12/22.
//
@testable import petWalk
import XCTest

class SetPetNameUseCaseTests: XCTestCase {
    private var sut: SetPetNameUseCaseImplementation!
    private var userDefaultsRepositoryMock: UserDefaultsRepositoryMock!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        userDefaultsRepositoryMock = UserDefaultsRepositoryMock()
        sut = SetPetNameUseCaseImplementation(repository: userDefaultsRepositoryMock)
    }

    func testThatPetNameIsSaved_When_ExecuteIsCalled() throws {
        sut.execute(name: "nameMock")
        
        XCTAssertEqual(1, userDefaultsRepositoryMock.setPetNameNameCallsCount)
    }
}
