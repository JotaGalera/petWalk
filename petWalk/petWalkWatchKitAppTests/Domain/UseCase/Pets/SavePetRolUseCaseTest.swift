//
//  SavePetRolUseCaseTest.swift
//  petWalkWatchKitAppTests
//
//  Created by Galera, Javier on 25/8/22.
//

import XCTest
@testable import petWalkWatchKitExtension

class SavePetRolUseCaseTest: XCTestCase {
    var sut: SavePetRolUseCase!
    var repository: UserDefaultsRepositoryMock!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        repository = UserDefaultsRepositoryMock()
        sut = SavePetRolUseCaseImplementation(repository: repository)
    }
    
    func testThatPetRolIsSavedInMemory_When_ExecuteIsCalled() {
        let rolMock = "rolMock"
        
        sut.execute(rolMock)
        
        XCTAssertEqual(1, repository.savePetRolCallsCount)
    }
}
