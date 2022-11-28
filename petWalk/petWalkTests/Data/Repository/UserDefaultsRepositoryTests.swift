//
//  UserDefaultsRepositoryTests.swift
//  petWalkTests
//
//  Created by Galera, Javier on 28/11/22.
//
@testable import petWalk
import XCTest

class UserDefaultsRepositoryTests: XCTestCase {
    private var sut: UserDefaultsRepositoryImplementation!
    private var userDefaultsDataSourceMock: UserDefaultDataSourceMock!
    
    override func setUpWithError() throws {
        userDefaultsDataSourceMock = UserDefaultDataSourceMock()
        
        sut = UserDefaultsRepositoryImplementation(userDefaultsDataSource: userDefaultsDataSourceMock)
    }

    func testThatPetNameIsRetrieved_When_GetPetNameIsCalled() {
        let petName = sut.getPetName()
        
        XCTAssertEqual(1, userDefaultsDataSourceMock.getCallsCount)
        XCTAssertEqual("nameMock", petName)
        XCTAssertEqual(.petName, userDefaultsDataSourceMock.getParamForKeyReceived)
    }

    func testThatPetLevelIsRetrieved_When_GetPetLevelIsCalled() {
        let petLevel = sut.getPetLevel()
        
        XCTAssertEqual(1, petLevel)
        XCTAssertEqual(1, userDefaultsDataSourceMock.getCallsCount)
        XCTAssertEqual(.petLevel, userDefaultsDataSourceMock.getParamForKeyReceived)
    }

    func testThatPetRollIsRetrieved_When_GetPetRolIsCalled() {
        let petRol = sut.getPetRol()
        
        XCTAssertEqual("rolMock", petRol)
        XCTAssertEqual(1, userDefaultsDataSourceMock.getCallsCount)
        XCTAssertEqual(.petRol, userDefaultsDataSourceMock.getParamForKeyReceived)
    }
}
