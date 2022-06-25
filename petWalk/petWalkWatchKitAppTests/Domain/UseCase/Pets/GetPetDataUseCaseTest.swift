//
//  GetPetDataUseCaseTest.swift
//  petWalkWatchKitAppTests
//
//  Created by Galera, Javier on 4/6/22.
//

@testable import petWalkWatchKitExtension
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
        let petMock = Swordman(name: "Beldrick", level: Level(), stats: Stats())
        repository.getPetNameReturnValue = "Beldrick"
        
        let pet = sut.execute()
        
        XCTAssertEqual(petMock, pet as! Swordman)
    }
}

