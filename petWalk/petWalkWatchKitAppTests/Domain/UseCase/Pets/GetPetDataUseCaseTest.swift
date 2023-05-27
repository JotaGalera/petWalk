//
//  GetPetDataUseCaseTest.swift
//  petWalkWatchKitAppTests
//
//  Created by Galera, Javier on 4/6/22.
//

@testable import petWalkWatchKitApp
import XCTest

class GetPetDataUseCaseTest: XCTestCase {
    private var sut: GetPetDataUseCase!
    private var repository: UserDefaultsRepositoryMock!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        repository = UserDefaultsRepositoryMock()
        sut = GetPetDataUseCaseImplementation(repository: repository)
    }
    
    func testThatAPetIsReturned_When_GetPetDataUseCaseIsCalled() {
        let petMock = Pet(name: "Beldrick", rol: Swordman(), level: Level())
        repository.getPetNameReturnValue = "Beldrick"
        repository.getPetLevelReturnValue = 1
        repository.getPetRolReturnValue = "Swordman"
        
        let pet = sut.execute()
        
        XCTAssertEqual(petMock, pet as! Pet)
        XCTAssertEqual(1, repository.getPetNameCallsCount)
        XCTAssertEqual(1, repository.getPetLevelCallsCount)
        XCTAssertEqual(1, repository.getPetRolCallsCount)
    }
}

