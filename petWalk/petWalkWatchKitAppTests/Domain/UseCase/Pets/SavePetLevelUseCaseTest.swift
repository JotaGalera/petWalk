//
//  SavePetLevelUseCaseTest.swift
//  petWalkWatchKitAppTests
//
//  Created by Galera, Javier on 3/8/22.
//

@testable import petWalkWatchKitExtension
import XCTest

class SavePetLevelUseCaseTest: XCTest {
    var sut: SavePetLevelUseCase!
    var repository: UserDefaultsRepositoryMock!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        repository = UserDefaultsRepositoryMock()
        sut = SavePetLevelUseCaseImplementation(repository: repository)
    }
    
    func testThatPetLevelIsSavedOnMemory_When_ExecuteIsCalled() {
        let currentLevelMock = 2
        
        sut.execute(currentLevelMock)
        
        XCTAssertEqual(1, repository.savePetLevelCallsCount)
        XCTAssertEqual(2, repository.savePetLevelReceivedLevel)
    }
}
