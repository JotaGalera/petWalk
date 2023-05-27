//
//  SavePetNameUseCaseTest.swift
//  petWalkWatchKitAppTests
//
//  Created by Galera, Javier on 19/6/22.
//

@testable import petWalkWatchKitApp
import XCTest

class SavePetNameUseCaseTest: XCTestCase {
    private var sut: SavePetNameUseCase!
    private var userDefaultsRepositoryMock: UserDefaultsRepositoryMock!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        userDefaultsRepositoryMock = UserDefaultsRepositoryMock()
        sut = SavePetNameUseCaseImplementation(repository: userDefaultsRepositoryMock)
    }
    
    func testThatPetNameIsSavedInUserDefaults_When_ExecuteIsCall() {
        let nameMock = "nameMock"
        
        sut.execute(nameMock)
        
        XCTAssertEqual(nameMock, userDefaultsRepositoryMock.savePetNameReceivedName)
        XCTAssertEqual(1, userDefaultsRepositoryMock.savePetNameCallsCount)
    }
}
