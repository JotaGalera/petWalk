//
//  SavePetLevelUseCaseTest.swift
//  petWalkWatchKitAppTests
//
//  Created by Galera, Javier on 3/8/22.
//

import XCTest
@testable import petWalkWatchKitExtension

class SavePetLevelUseCaseTest: XCTestCase {
    var sut: SavePetLevelUseCase!
    var repository: UserDefaultsRepositoryMock!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        repository = UserDefaultsRepositoryMock()
        
        sut = SavePetLevelUseCaseImplementation(repository: repository)
    }
    
    func testThatPetLevelIsSavedOnMemory_When_ExecuteIsCalled() {
        let currentLevelMocked = 2
        
        sut.execute(currentLevelMocked)
        
        XCTAssertEqual(1, repository.savePetLevelCallsCount)
        XCTAssertEqual(2, repository.savePetLevelReceivedLevel)
    }
}
